//
//  Level1Layer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "Level1Layer.h"

@interface Level1Layer () {

}

@end

@implementation Level1Layer

- (id)init {
    if ((self = [super init])) {
        self.level = 1;
        _enemyCount = 5;
        
        [self createTieldMap];
        
        [self createStausBar:30 score:0];
    }
    return self;
}

@end
