//
//  Enemy.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelLayerDelegate.h"

@class Tower;

@interface Enemy : CCNode {
    
}

@property (nonatomic, strong) NSMutableArray *linePositionArray;
@property (nonatomic, unsafe_unretained) CGPoint currentPosition;
@property (nonatomic, unsafe_unretained) CGPoint nextPosition;
@property (nonatomic, unsafe_unretained) int hp;
@property (nonatomic, unsafe_unretained) int walkSpeed;
@property (nonatomic, unsafe_unretained) int current_hp;
@property (nonatomic, strong) CCSprite *enemySprite;
@property (nonatomic, unsafe_unretained) int worth;
@property (nonatomic, unsafe_unretained) int score;

@property (nonatomic, unsafe_unretained) id<LevelLayerDelegate> delegate;
@property (nonatomic, unsafe_unretained) BOOL isActive;

@property (nonatomic, strong) NSMutableArray *attackedByArray;

+ (id)nodeWithLinePositions:(NSArray *)linePositions;

- (id)initWithLinePositions:(NSArray *)linePositions;

- (void)getDamaged:(int)damage;

- (void)attackByTower:(Tower *)tower;

@end
