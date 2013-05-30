//
//  HudLayer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"


@implementation HudLayer

+ (id)nodeWithWon:(BOOL)won currentLevel:(int)level {
    return [[self alloc] initWithWon:won currentLevel:level];
}

- (id)initWithWon:(BOOL)won currentLevel:(int)level {
    if ((self = [super init])) {
        
    }
    return self;
}

@end
