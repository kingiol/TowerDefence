//
//  HudLayer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "HudLayer.h"
#import "HelloWorldLayer.h"
#import "LevelScene.h"

@interface HudLayer ()

@property (nonatomic, unsafe_unretained) int level;

@end

@implementation HudLayer

@synthesize level = _level;

+ (CCScene *)scene {
    return nil;
}

+ (id)nodeWithWon:(BOOL)won currentLevel:(int)level {
    return [[self alloc] initWithWon:won currentLevel:level];
}

- (id)initWithWon:(BOOL)won currentLevel:(int)level {
    if ((self = [super init])) {
        
        self.level = level;
        
        NSString *message;
        if (won) {
            message = @"You win!";
        }else {
            message = @"You lose!";
        }
        CCLabelBMFont *msgLabel = [CCLabelBMFont labelWithString:message fntFile:FONT_ARIAL];
        msgLabel.scale = 0.1;
        msgLabel.position = ccp(winSizeWidth*0.5, winSizeHeight*3/4);
        [self addChild:msgLabel];
        
        CCLabelBMFont *restartLabel = [CCLabelBMFont labelWithString:@"Restart" fntFile:FONT_ARIAL];
        CCLabelBMFont *nextLabel = [CCLabelBMFont labelWithString:@"Next" fntFile:FONT_ARIAL];
        CCLabelBMFont *goBackLabel = [CCLabelBMFont labelWithString:@"Go Back" fntFile:FONT_ARIAL];
        
        CCMenuItemLabel *restartItem = [CCMenuItemLabel itemWithLabel:restartLabel target:self selector:@selector(restartGame:)];
        restartItem.scale = 0.1;
        CCMenuItemLabel *nextItem = [CCMenuItemLabel itemWithLabel:nextLabel target:self selector:@selector(nextGame:)];
        nextItem.scale = 0.1;
        CCMenuItemLabel *goBackItem = [CCMenuItemLabel itemWithLabel:goBackLabel target:self selector:@selector(goBack:)];
        goBackItem.scale = 0.1;
        
        CCMenu *menu = nil;
        if (won && self.level != 3) {
            menu = [CCMenu menuWithItems:restartItem, nextItem, goBackItem, nil];
        }else {
            menu = [CCMenu menuWithItems:restartItem, goBackItem, nil];
        }
        [menu alignItemsVerticallyWithPadding:30];
        menu.position = ccp(winSizeWidth*0.5, winSizeHeight*0.5);
        [self addChild:menu z:20];
        
        [msgLabel runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
        [restartItem runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
        [nextItem runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
        [goBackItem runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
    }
    return self;
}

- (void)restartGame:(id)sender {
    NSString *classStr = [NSString stringWithFormat:@"Level%dLayer", self.level];
    CCScene *scene = [LevelScene scene:classStr];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:0.5 scene:scene]];
}

- (void)nextGame:(id)sender {
    NSString *classStr = [NSString stringWithFormat:@"Level%dLayer", ++self.level];
    CCLOG(@"classStr-->:%@", classStr);
    CCScene *scene = [LevelScene scene:classStr];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:scene]];
}

- (void)goBack:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.5 scene:[HelloWorldLayer scene]]];
}

@end
