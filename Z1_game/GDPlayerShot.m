//
//  GDPlayerShot.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/9/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDPlayerShot.h"


@implementation GDPlayerShot

@synthesize timeAlive, hitSomething, decay = _decay;

+ (GDPlayerShot*) shotAtRotation:(float)inRotation anchorPoint:(CGPoint)inPoint
{
    GDPlayerShot* aShot = [[GDPlayerShot alloc] initWithFile:@"shot.png"];
    aShot.scale = 0.15;
    aShot.rotation = inRotation;
    aShot.anchorPoint = inPoint;
    
    return [aShot autorelease];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.timeAlive = 0.0;
        self.hitSomething = NO;
    }
    return self;
}

@end
