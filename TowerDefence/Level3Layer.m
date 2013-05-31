//
//  Level3Layer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "Level3Layer.h"


@implementation Level3Layer

- (id)init {
    if ((self = [super init])) {
        self.level = 3;
        _enemyCount = 15;
        
        [self createTieldMap];
        
        [self createStausBar:90 score:0];
    }
    return self;
}

@end
