//
//  HudLayer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"

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
        msgLabel.position = ccp(winSizeWidth*0.5, winSizeHeight*0.5);
        [self addChild:msgLabel];
        
        CCLabelBMFont *restartLabel = [CCLabelBMFont labelWithString:@"Restart" fntFile:FONT_ARIAL];
        CCLabelBMFont *nextLabel = [CCLabelBMFont labelWithString:@"Next" fntFile:FONT_ARIAL];
        
        CCMenuItemLabel *restartItem = [CCMenuItemLabel itemWithLabel:restartLabel target:self selector:@selector(restartGame:)];
        restartItem.scale = 0.1;
        CCMenuItemLabel *nextItem = [CCMenuItemLabel itemWithLabel:nextLabel target:self selector:@selector(nextGame:)];
        nextItem.scale = 0.1;
        
        CCMenu *menu = nil;
        if (won && self.level != 3) {
            menu = [CCMenu menuWithItems:restartItem, nextItem, nil];
        }else {
            menu = [CCMenu menuWithItems:restartItem, nil];
        }
        [menu alignItemsVerticallyWithPadding:30];
        menu.position = ccp(winSizeWidth*0.5, winSizeHeight/3);
        [self addChild:menu z:20];
        
        [msgLabel runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
        [restartItem runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
        [nextItem runAction:[CCScaleTo actionWithDuration:0.5 scale:1.0]];
    }
    return self;
}

- (void)restartGame:(id)sender {
    NSString *classStr = [NSString stringWithFormat:@"Level%dLayer", self.level];
    CCScene *scene = [[NSClassFromString(classStr) class] scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:0.5 scene:scene]];
}

- (void)nextGame:(id)sender {
    NSString *classStr = [NSString stringWithFormat:@"Level%dLayer", ++self.level];
    CCScene *scene = [[NSClassFromString(classStr) class] scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:scene]];
}

@end
