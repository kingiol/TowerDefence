//
//  StatusLayer.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import "StatusLayer.h"

@interface StatusLayer () {
    CCLabelBMFont *_goldLabel;
    CCLabelBMFont *_scoreLabel;
}

@end

@implementation StatusLayer

@synthesize currentGold = _currentGold;
@synthesize currentScore = _currentScore;

+ (id)nodeWithGold:(int)gold score:(int)score {
    return [[self alloc] initWithGold:gold score:score];
}

- (id)initWithGold:(int)gold score:(int)score {
    if ((self = [super init])) {
        self.currentGold = gold;
        self.currentScore = score;
        
        CCSprite *icon_gold = [CCSprite spriteWithFile:@"icon_gold.png"];
        icon_gold.position = ccp(icon_gold.contentSize.width/2, winSizeHeight-icon_gold.contentSize.height/2-5);
        [self addChild:icon_gold];
        
        _goldLabel = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@":%d", gold] fntFile:FONT_ARIAL];
        _goldLabel.position = ccp(icon_gold.contentSize.width + _goldLabel.contentSize.width/2, winSizeHeight-_goldLabel.contentSize.height/2);
        [self addChild:_goldLabel];
        
        _scoreLabel = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"Score:%d", score] fntFile:FONT_ARIAL];
        _scoreLabel.position = ccp(winSizeWidth-_scoreLabel.contentSize.width/2-45,winSizeHeight-_scoreLabel.contentSize.height/2);
        [self addChild:_scoreLabel];
    }
    return self;
}

- (void)updateGold:(int)gold {
    self.currentGold += gold;
    if (self.currentGold <= 0) {
        self.currentGold = 0;
    }
    _goldLabel.string = [NSString stringWithFormat:@":%d", self.currentGold];
}

- (void)updateScore:(int)score {
    self.currentScore += score;
    if (self.currentScore <= 0) {
        self.currentScore = 0;
    }
    _scoreLabel.string = [NSString stringWithFormat:@"Score:%d", self.currentScore];
}

@end
