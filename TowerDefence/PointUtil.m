//
//  PointUtil.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//
//

#import "PointUtil.h"
#import "cocos2d.h"

@implementation PointUtil

+ (BOOL)circle:(CGPoint)point withRadius:(int)pointRadius collsionWithCircle:(CGPoint)collsionPoint collisionCircleRadius:(int)collsionRadius {
    float distance = ccpDistance(point, collsionPoint);
    if (distance <= pointRadius + collsionRadius) {
        return YES;
    }
    return NO;
}

@end
