//
//  TieldMapUtil.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//
//

#import "TieldMapUtil.h"

@implementation TieldMapUtil

@synthesize tileMap = _tileMap;

- (id)initWithMap:(CCTMXTiledMap *)tileMap {
    if ((self = [super init])) {
        _tileMap = tileMap;
    }
    return self;
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    CGSize tileSize = CGSizeMake(self.tileMap.tileSize.width, self.tileMap.tileSize.height);
    if (IS_HD) {
        tileSize = CGSizeMake(self.tileMap.tileSize.width/2, self.tileMap.tileSize.height/2);
    }
    int x = position.x / tileSize.width;
    int y = ((self.tileMap.mapSize.height * tileSize.height) - position.y) / tileSize.height;
    return ccp(x, y);
}

- (CGPoint)positionForTileCoord:(CGPoint)tileCoord {
    CGSize tileSize = CGSizeMake(self.tileMap.tileSize.width, self.tileMap.tileSize.height);
    if (IS_HD) {
        tileSize = CGSizeMake(self.tileMap.tileSize.width/2, self.tileMap.tileSize.height/2);
    }
    int x = tileCoord.x * tileSize.width + tileSize.width/2;
    int y = (self.tileMap.mapSize.height - tileCoord.y) * tileSize.height - tileSize.height/2;
    return ccp(x, y);
}

- (int)spriteScale {
    if (IS_HD) {
        return 2;
    }
    return 1;
}

- (int)getTieldHeightForRetina {
    if (IS_HD) {
        return TILE_HEIGHT_HD;
    }
    return TILE_HEIGHT;
}

- (NSArray *)linePositionArray:(NSArray *)tileCoordArray {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dict in tileCoordArray) {
        int x = [dict[@"x"] intValue];
        int y = [dict[@"y"] intValue];
        CGPoint tileCoord = ccp(x, y);
        CGPoint position = [self positionForTileCoord:tileCoord];
        [array addObject:NSStringFromCGPoint(position)];
    }
    
    return array;
}

@end
