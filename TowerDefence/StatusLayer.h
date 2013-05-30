//
//  StatusLayer.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusLayer : CCLayer {
    
}

@property (nonatomic, unsafe_unretained) int currentGold;
@property (nonatomic, unsafe_unretained) int currentScore;

+ (id)nodeWithGold:(int)gold score:(int)score;
- (id)initWithGold:(int)gold score:(int)score;

- (void)updateGold:(int)gold;
- (void)updateScore:(int)score;

@end
