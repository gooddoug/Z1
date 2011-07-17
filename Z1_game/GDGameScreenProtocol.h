//
//  GDGameScreenProtocol.h
//  MenuTest
//
//  Created by Doug Whitmore on 7/11/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GDInputManager;

@protocol GDGameScreenProtocol <NSObject>

@property (retain, nonatomic) GDInputManager* inputManager;
@property (retain, nonatomic) CCSprite* playerSprite;

@property (retain, nonatomic) NSMutableArray* enemySprites;

- (void) addEnemySprite:(id)aSprite;

@end
