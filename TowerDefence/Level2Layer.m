//
//  Level2Layer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "Level2Layer.h"


@implementation Level2Layer

@synthesize level = _level;

+ (CCScene *)scene {
    CCScene *scene = [CCScene node];
    Level2Layer *layer = [Level2Layer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    if ((self = [super init])) {
        _level = 2;
    }
    return self;
}

@end
