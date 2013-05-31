//
//  Level2Layer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "Level2Layer.h"


@implementation Level2Layer

- (id)init {
    if ((self = [super init])) {
        self.level = 2;
        _enemyCount = 10;
        
        [self createTieldMap];
        
        [self createStausBar:60 score:0];
    }
    return self;
}

@end
