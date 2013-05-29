//
//  Enemy.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCNode {
    
}

@property (nonatomic, strong) NSMutableArray *linePositionArray;
@property (nonatomic, unsafe_unretained) CGPoint currentPosition;
@property (nonatomic, unsafe_unretained) CGPoint nextPosition;
@property (nonatomic, unsafe_unretained) int hp;
@property (nonatomic, unsafe_unretained) int walkSpeed;
@property (nonatomic, unsafe_unretained) int current_hp;
@property (nonatomic, strong) CCSprite *enemySprite;

+ (id)nodeWithLinePositions:(NSArray *)linePositions;

- (id)initWithLinePositions:(NSArray *)linePositions;

@end
