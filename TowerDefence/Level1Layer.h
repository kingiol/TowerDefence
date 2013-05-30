//
//  Level1Layer.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//  Copyright 2013年 www.coamee.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelLayerDelegate.h"

@interface Level1Layer : CCLayer <LevelLayerDelegate> {
    
}

@property (nonatomic, unsafe_unretained) int level;
@property (nonatomic, strong) CCTMXTiledMap *tmxTiledMap;

@property (nonatomic, strong) NSMutableArray *enemiesArray;

+ (CCScene *)scene;

@end
