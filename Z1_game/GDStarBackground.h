//
//  GDStarBackground.h
//  Z1_game
//
//  Created by Doug Whitmore on 8/30/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDEffectProtocol.h"
#import "cocos2d.h"

@interface GDStarBackground : CCNode <GDEffectProtocol>
{
    int howManyStars;
    float scaleLow;
    float scaleHigh;
}

@property int howManyStars;
@property float scaleLow;
@property float scaleHigh;

+ (GDStarBackground*) starBackground;

@end
