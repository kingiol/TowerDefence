//
//  LevelUtil.m
//  TowerDefence
//
//  Created by Kingiol on 13-5-29.
//
//

#import "LevelUtil.h"

@implementation LevelUtil

+ (NSArray *)loadLinePositions:(int)level {
    NSString *levelStr = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d", level] ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:levelStr];
    NSArray *array = dictionary[@"linePoints"];
    return array;
}

@end
