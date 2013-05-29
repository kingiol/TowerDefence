//
//  PointUtil.h
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//
//

#import <Foundation/Foundation.h>

@interface PointUtil : NSObject

+ (BOOL)circle:(CGPoint)point withRadius:(int)pointRadius collsionWithCircle:(CGPoint)collsionPoint collisionCircleRadius:(int)collsionRadius;

@end
