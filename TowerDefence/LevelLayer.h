//
//  LevelLayer.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LevelLayerDelegate.h"

@class TieldMapUtil, StatusLayer;

@interface LevelLayer : CCLayer <LevelLayerDelegate> {
    CCTMXLayer *_backgroundLayer;
    CCTMXLayer *_metaLayer;
    TieldMapUtil *_tieldMapUtil;
    CCTMXObjectGroup *_objectGroup;
    CCLabelBMFont *_mountainHpLabel;
    
    StatusLayer *_statusLayer;
    
    int _enemyCount;
}

@property (nonatomic, unsafe_unretained) int level;
@property (nonatomic, strong) CCTMXTiledMap *tmxTiledMap;
@property (nonatomic, strong) NSArray *linePositions;
@property (nonatomic, strong) NSMutableArray *enemiesArray;

- (void)createTieldMap;
- (void)createStausBar:(int)gold score:(int)score;
- (void)achieveLinePositions;
- (void)createEnemy;
- (void)scheduleMethod;

@end
