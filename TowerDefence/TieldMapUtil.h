//
//  TieldMapUtil.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TieldMapUtil : NSObject

@property (nonatomic, unsafe_unretained) CCTMXTiledMap *tileMap;

- (id)initWithMap:(CCTMXTiledMap *)tileMap;

- (CGPoint)tileCoordForPosition:(CGPoint)position;
- (CGPoint)positionForTileCoord:(CGPoint)tileCoord;

- (NSArray *)linePositionArray:(NSArray *)tileCoordArray;

@end
