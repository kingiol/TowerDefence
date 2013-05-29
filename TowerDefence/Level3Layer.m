//
//  Level3Layer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "Level3Layer.h"


@implementation Level3Layer

@synthesize level = _level;

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    Level3Layer *layer = [Level3Layer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {
        _level = 3;
    }
    return self;
}

@end
