//
//  GDBaseEffectsScreen.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GDBaseEffectsScreen : CCLayer 
{
    NSArray* _effects;
}

@property (nonatomic, retain) NSArray* effects;

- (id) initWithEffects:(NSArray*)inEffects;
- (id) initWithEffectNames:(NSArray *)inNames;

@end
