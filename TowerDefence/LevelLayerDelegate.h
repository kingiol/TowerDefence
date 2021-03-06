//
//  LevelLayerProtocol.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-30.
//
//

#import <Foundation/Foundation.h>

@protocol LevelLayerDelegate <NSObject>

@required
- (void)updateMountainHP;
- (NSMutableArray *)getEnemiesArray;
- (void)addBullet:(CCSprite *)bullet;
- (void)updateStatusWithGold:(int)gold score:(int)score;

@end
