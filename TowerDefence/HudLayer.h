//
//  HudLayer.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HudLayer : CCLayer {
    
}

+ (id)nodeWithWon:(BOOL)won currentLevel:(int)level;
- (id)initWithWon:(BOOL)won currentLevel:(int)level;

@end
