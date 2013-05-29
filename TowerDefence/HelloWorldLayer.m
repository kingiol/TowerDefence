//
//  HelloWorldLayer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright www.coamee.com 2013年. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "SimpleAudioEngine.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        CCSprite *background = [CCSprite spriteWithFile:@"index-background.png"];
        [self addChild:background z:-1];
        background.anchorPoint = ccp(0, 0);
        
        CCLabelBMFont *fontLevel1 = [CCLabelBMFont labelWithString:@"Level 1" fntFile:FONT_ARIAL];
        CCLabelBMFont *fontLevel2 = [CCLabelBMFont labelWithString:@"Level 2" fntFile:FONT_ARIAL];
        CCLabelBMFont *fontLevel3 = [CCLabelBMFont labelWithString:@"Level 3" fntFile:FONT_ARIAL];
        
        CCMenuItemLabel *labelLevel1 = [CCMenuItemLabel itemWithLabel:fontLevel1 target:self selector:@selector(levelTapped:)];
        labelLevel1.tag = 1;
        CCMenuItemLabel *labelLevel2 = [CCMenuItemLabel itemWithLabel:fontLevel2 target:self selector:@selector(levelTapped:)];
        labelLevel2.tag = 2;
        CCMenuItemLabel *labelLevel3 = [CCMenuItemLabel itemWithLabel:fontLevel3 target:self selector:@selector(levelTapped:)];
        labelLevel3.tag = 3;
        
        CCMenu *menu = [CCMenu menuWithItems:labelLevel1, labelLevel2, labelLevel3, nil];
        
        [self controllMenuItemEnable:menu];
        
        [menu alignItemsVerticallyWithPadding:20.0f];
        menu.position = ccp(winSizeWidth/2, winSizeHeight/3);
        [self addChild:menu z:0];
	}
	return self;
}

- (void)controllMenuItemEnable:(CCMenu *)menu {
    for (CCMenuItem *item in menu.children) {
        NSInteger tag = item.tag;
        NSString *plistStr = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d", tag] ofType:@"plist"];
        NSDictionary *dictory = [NSDictionary dictionaryWithContentsOfFile:plistStr];       
        if ([dictory[@"isFirst"] boolValue] || [dictory[@"isRun"] boolValue] || [dictory[@"passed"] boolValue]) {
            item.isEnabled = YES;
        }else {
            item.isEnabled = NO;
        }
    }
}

- (void)levelTapped:(id)sender {
    NSAssert([sender isKindOfClass:[CCMenuItem class]], @"sender menu is not a CCMenuItem instance.");
    CCMenuItem *item = (CCMenuItem *)sender;
    NSInteger tag = item.tag;
    NSString *classStr = [NSString stringWithFormat:@"Level%dLayer", tag];
    CCScene *scene = [[NSClassFromString(classStr) class] scene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:1.0f scene:scene]];
}

@end
