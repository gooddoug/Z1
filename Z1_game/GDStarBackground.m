//
//  GDStarBackground.m
//  Z1_game
//
//  Created by Doug Whitmore on 8/30/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDStarBackground.h"


@implementation GDStarBackground

@synthesize howManyStars, scaleHigh, scaleLow;

+ (GDStarBackground*) starBackground
{
    return [[[self alloc] init] autorelease];
}

- (id) initWithHowMany:(int)inHowMany scaleLow:(float)inScaleLow scaleHigh:(float)inScaleHigh
{
    if ((self = [super init]))
    {
        self.howManyStars = inHowMany;
        self.scaleLow = inScaleLow;
        self.scaleHigh = inScaleHigh;
    }
    return self;
}

- (id) init
{
    return [self initWithHowMany:150 scaleLow:0.1 scaleHigh:1.5];
}

@end

