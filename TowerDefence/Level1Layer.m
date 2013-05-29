//
//  Level1Layer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "Level1Layer.h"


@implementation Level1Layer

@synthesize level = _level;

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    Level1Layer *layer = [Level1Layer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {
        _level = 1;
        CCLOG(@"init...");
    }
    return self;
}

@end
