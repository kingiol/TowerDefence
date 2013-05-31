//
//  Tower.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "Tower.h"

#import "PointUtil.h"

@interface Tower ()

@property (nonatomic, strong) CCSprite *towerSprite;

@end

@implementation Tower

@synthesize towerSprite = _towerSprite;

@synthesize damageRange = _damageRange;
@synthesize fireRate = _fireRate;
@synthesize fireInterval = _fireInterval;
@synthesize bulletSpeed = _bulletSpeed;
@synthesize isAttacking = _isAttacking;
@synthesize choosedEnemy = _choosedEnemy;
@synthesize cost = _cost;

@synthesize delegate = _delegate;

+ (id)nodeWithPosition:(CGPoint)position {
    return [[self alloc] initWithPosition:position];
}

- (id)initWithPosition:(CGPoint)position {
    if ((self = [super init])) {
        self.damageRange = RANDOM_INT_INCLUDE(1, 3);
        self.fireRate = RANDOM_INT_INCLUDE(70, 90);
//        self.fireInterval = RANDOM_INT_INCLUDE(1, 2);
        self.fireInterval = 1 + RANDOM_INT(1);
        self.bulletSpeed = RANDOM_INT_INCLUDE(50, 60);
        self.isAttacking = NO;
        self.choosedEnemy = nil;
        self.cost = 15;
        
        self.towerSprite = [CCSprite spriteWithFile:@"tower.png"];
        [self addChild:self.towerSprite];
        self.towerSprite.position = position;
        
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)delta {
    
    if (self.choosedEnemy) {
        CGPoint normalized = ccpNormalize(ccp(self.choosedEnemy.enemySprite.position.x - self.towerSprite.position.x, self.choosedEnemy.enemySprite.position.y - self.towerSprite.position.y));
        self.towerSprite.rotation = CC_RADIANS_TO_DEGREES(atan2(normalized.y, -normalized.x)) + 90;
        
        if (![PointUtil circle:self.towerSprite.position withRadius:self.fireRate collsionWithCircle:self.choosedEnemy.enemySprite.position collisionCircleRadius:1]) {
            [self lostChooseEnemy];
        }
        
    }else {
        
        for (Enemy *enemy in [self.delegate getEnemiesArray]) {
            if ([PointUtil circle:self.towerSprite.position withRadius:self.fireRate collsionWithCircle:enemy.enemySprite.position collisionCircleRadius:1]) {
                [self chooseEnemyForAttack:enemy];
                break;
            }
        }
        
    }
}
                 
- (void)chooseEnemyForAttack:(Enemy *)enemy {
    self.choosedEnemy = enemy;
    [self attackEnemy];
    [self.choosedEnemy attackByTower:self];
}

- (void)attackEnemy {
    [self schedule:@selector(shootWeapon) interval:self.fireInterval];
}

- (void)shootWeapon {
    if (self.choosedEnemy) {
        CCSprite *bullet = [CCSprite spriteWithFile:@"bullet.png"];
        bullet.position = self.towerSprite.position;
        [self.delegate addBullet:bullet];
        [bullet runAction:[CCSequence actions:
                           [CCMoveTo actionWithDuration:0.1 position:self.choosedEnemy.enemySprite.position],
                           [CCCallFunc actionWithTarget:self selector:@selector(damageEnemy)],
                           [CCCallFuncN actionWithTarget:self selector:@selector(removeBullet:)], nil]];
    }
}

- (void)damageEnemy {
    [self.choosedEnemy getDamaged:self.damageRange];
}

- (void)removeBullet:(CCNode *)bullet {
    [bullet removeFromParentAndCleanup:YES];
}

- (void)lostChooseEnemy {
    self.choosedEnemy = nil;
    [self unschedule:@selector(shootWeapon)];
}

@end
