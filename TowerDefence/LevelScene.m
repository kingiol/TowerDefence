//
//  LevelScene.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-31.
//
//

#import "LevelScene.h"

#import "LevelLayer.h"

@implementation LevelScene

+ (CCScene *)scene:(NSString *)classStr {
    CCScene *scene = [CCScene node];
    LevelLayer *layer = [[NSClassFromString(classStr) class] node];
    [scene addChild:layer];
    return scene;
}

@end
