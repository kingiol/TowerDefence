//
//  LevelLayer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "LevelLayer.h"

#import "TieldMapUtil.h"
#import "StatusLayer.h"
#import "LevelUtil.h"
#import "Enemy.h"
#import "Tower.h"
#import "HudLayer.h"

@interface LevelLayer () {
    
}

@end

@implementation LevelLayer

@synthesize level = _level;
@synthesize tmxTiledMap = _tmxTiledMap;
@synthesize linePositions = _linePositions;

@synthesize enemiesArray = _enemiesArray;

- (void)createTieldMap{
    self.tmxTiledMap = [CCTMXTiledMap tiledMapWithTMXFile:[NSString stringWithFormat:@"Level%dTield.tmx", self.level]];
    [self addChild:self.tmxTiledMap z:-1];
    
    _tieldMapUtil = [[TieldMapUtil alloc] initWithMap:self.tmxTiledMap];
    
    _backgroundLayer = [self.tmxTiledMap layerNamed:@"Background"];
    _metaLayer = [self.tmxTiledMap layerNamed:@"Meta"];
    _metaLayer.visible = NO;
    _objectGroup = [self.tmxTiledMap objectGroupNamed:@"MountainObject"];
    
    [self createMountain];
}

- (void)createStausBar:(int)gold score:(int)score {
    _statusLayer = [StatusLayer nodeWithGold:gold score:score];
    [self addChild:_statusLayer z:15];
    [self achieveLinePositions];
    [self createEnemy];
}

- (void)achieveLinePositions {
    NSArray *linePoints = [LevelUtil loadLinePositions:self.level];
    self.linePositions = [_tieldMapUtil linePositionArray:linePoints];
}

- (void)createEnemy {
    self.enemiesArray = [NSMutableArray arrayWithCapacity:_enemyCount];
    for (int i = 0; i < _enemyCount; i++) {
        Enemy *enemy = [Enemy nodeWithLinePositions:self.linePositions];
        enemy.delegate = self;
        [self addChild:enemy];
        [self.enemiesArray addObject:enemy];
    }
    [self schedule:@selector(produceEnemy) interval:1.0f repeat:_enemyCount delay:1];
    
    [self scheduleMethod];
}

- (void)scheduleMethod {
    self.isTouchEnabled = YES;
    [self scheduleUpdate];
}

- (void)produceEnemy {
    for (Enemy *enemy in self.enemiesArray) {
        if (!enemy.isActive) {
            enemy.isActive = YES;
            return;
        }
    }
}

- (void)onExit {
    [self unschedule:@selector(produceEnemy)];
}

- (void)createMountain {
    NSMutableDictionary *objectDict = [_objectGroup objectNamed:@"Mountain"];
    if (objectDict) {
        int scale = [_tieldMapUtil spriteScale];
        int x = [objectDict[@"x"] intValue] / scale;
        int y = [objectDict[@"y"] intValue] / scale;
        int width = [objectDict[@"width"] intValue] / scale;
        int height = [objectDict[@"height"] intValue] / scale;
        x += width/2;
        y += height/2;
        CCSprite *montainSprite = [CCSprite spriteWithFile:@"mountain.png"];
        [self addChild:montainSprite z:10];
        montainSprite.position = ccp(x, y);
        _mountainHpLabel = [CCLabelBMFont labelWithString:@"3" fntFile:FONT_ARIAL];
        [montainSprite addChild:_mountainHpLabel];
        _mountainHpLabel.anchorPoint = ccp(1, 0);
        _mountainHpLabel.position = ccp(montainSprite.contentSize.width, 0);
    }
}


- (void)dealloc {
    _backgroundLayer = nil;
    _metaLayer = nil;
    _tieldMapUtil = nil;
}

- (void)update:(ccTime)delta {
    int currentHp = [_mountainHpLabel.string intValue];
    int enemyCount = self.enemiesArray.count;
    if (currentHp <= 0) {
        for (Enemy *enemy in self.enemiesArray) {
            [enemy unscheduleUpdate];
            
            CCBlink *blink = [CCBlink actionWithDuration:5 blinks:30];
            [enemy runAction:blink];
        }
        HudLayer *layer = [HudLayer nodeWithWon:NO currentLevel:self.level];
        [self addChild:layer z:100];
        [self unscheduleUpdate];
    }else if (enemyCount == 0 && currentHp > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *levelPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d", self.level] ofType:@"plist"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:levelPath];
            if (dict) {
                [dict setObject:[NSNumber numberWithBool:YES] forKey:@"passed"];
                int score = _statusLayer.currentScore;
                [dict setObject:[NSNumber numberWithInt:score] forKey:@"score"];
                [dict writeToFile:levelPath atomically:YES];
            }
            NSString *nextLevelPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d", self.level + 1] ofType:@"plist"];
            NSMutableDictionary *nextDict = [NSMutableDictionary dictionaryWithContentsOfFile:nextLevelPath];
            if (nextDict) {
                [nextDict setObject:[NSNumber numberWithBool:YES] forKey:@"isRun"];
                [nextDict writeToFile:nextLevelPath atomically:YES];
            }
        });
        HudLayer *layer = [HudLayer nodeWithWon:YES currentLevel:self.level];
        [self addChild:layer z:100];
        [self unscheduleUpdate];
    }
}

#pragma mark - Touches

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPosition = [self.tmxTiledMap convertTouchToNodeSpace:touch];
    CGPoint tileCoord = [_tieldMapUtil tileCoordForPosition:touchPosition];
    
    NSUInteger tileGID = [_metaLayer tileGIDAt:tileCoord];
    if (!tileGID) {
        
        CGPoint position = [_tieldMapUtil positionForTileCoord:tileCoord];
        
        Tower *tower = [Tower nodeWithPosition:position];
        if (_statusLayer.currentGold - tower.cost >= 0) {
            tower.delegate = self;
            [self addChild:tower z:10];
            [_statusLayer updateGold:-tower.cost];
            [_metaLayer setTileGID:1 at:tileCoord];
        }else {
            tower = nil;
        }
    }
    
}


#pragma mark - LevelLayerDelegate

- (void)updateMountainHP {
    int currentHp = [_mountainHpLabel.string intValue];
    _mountainHpLabel.string = [NSString stringWithFormat:@"%d", --currentHp];
}

- (NSMutableArray *)getEnemiesArray {
    return self.enemiesArray;
}

- (void)addBullet:(CCSprite *)bullet {
    [self addChild:bullet z:10];
}

- (void)updateStatusWithGold:(int)gold score:(int)score {
    [_statusLayer updateGold:gold];
    [_statusLayer updateScore:score];
}

@end
