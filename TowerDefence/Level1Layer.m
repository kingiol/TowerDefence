//
//  Level1Layer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "Level1Layer.h"
#import "TieldMapUtil.h"
#import "LevelUtil.h"
#import "Enemy.h"

@interface Level1Layer () {
    CCTMXLayer *_backgroundLayer;
    CCTMXLayer *_metaLayer;
    TieldMapUtil *_tieldMapUtil;
}

@property (nonatomic, strong) NSArray *linePositions;

@end

@implementation Level1Layer

@synthesize level = _level;
@synthesize tmxTiledMap = _tmxTiledMap;
@synthesize linePositions = _linePositions;

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    Level1Layer *layer = [Level1Layer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {
        _level = 1;
        _tmxTiledMap = [CCTMXTiledMap tiledMapWithTMXFile:@"Level1Tield.tmx"];
        [self addChild:_tmxTiledMap z:-1];
        _backgroundLayer = [_tmxTiledMap layerNamed:@"Background"];
        _metaLayer = [_tmxTiledMap layerNamed:@"Meta"];
        _metaLayer.visible = NO;
        
        _tieldMapUtil = [[TieldMapUtil alloc] initWithMap:_tmxTiledMap];
        
        NSArray *linePoints = [LevelUtil loadLinePositions:_level];
        
        self.linePositions = [_tieldMapUtil linePositionArray:linePoints];
        
//        [self schedule:@selector(createEnemy) interval:1.0f repeat:10 delay:1];
        
        Enemy *enemy = [Enemy nodeWithLinePositions:self.linePositions];
        [self addChild:enemy];
        
        self.isTouchEnabled = YES;
    }
    return self;
}

- (void)createEnemy {
    CCLOG(@"createEnemy::");
}

- (void)dealloc {
    _backgroundLayer = nil;
    _metaLayer = nil;
    _tieldMapUtil = nil;
}

#pragma mark - Touches

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPosition = [_tmxTiledMap convertTouchToNodeSpace:touch];
    CGPoint tileCoord = [_tieldMapUtil tileCoordForPosition:touchPosition];
    
    NSUInteger tileGID = [_metaLayer tileGIDAt:tileCoord];
    if (!tileGID) {
        [_metaLayer setTileGID:1 at:tileCoord];
        
        CGPoint position = [_tieldMapUtil positionForTileCoord:tileCoord];
        CCSprite *tower = [CCSprite spriteWithFile:@"tower.png"];
        [self addChild:tower z:10];
        tower.position = position;
    }
    
}

@end
