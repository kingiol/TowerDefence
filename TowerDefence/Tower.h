//
//  Tower.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy.h"
#import "LevelLayerDelegate.h"

@interface Tower : CCNode {
    
}

@property (nonatomic, unsafe_unretained) int damageRange;
@property (nonatomic, unsafe_unretained) int fireRate;
@property (nonatomic, unsafe_unretained) int fireInterval;
@property (nonatomic, unsafe_unretained) int bulletSpeed;
@property (nonatomic, unsafe_unretained) BOOL isAttacking;
@property (nonatomic, unsafe_unretained) Enemy *choosedEnemy;

@property (nonatomic, unsafe_unretained) id<LevelLayerDelegate> delegate;

+ (id)nodeWithPosition:(CGPoint)position;
- (id)initWithPosition:(CGPoint)position;

@end
