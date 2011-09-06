//
//  GDEnemyBase.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/5/11.
//  Copyright 2011 Doug Whitmore All rights reserved.
//

#import "GDUnboundSprite.h"

@interface GDUnboundSprite()

@end

@implementation GDUnboundSprite

@synthesize moveSelf;

- (id) init
{
    if ((self = [super init]))
    {
        [self scheduleUpdate];
        self.moveSelf = YES;
    }
    return self;
}


- (CGPoint) heading
{
    // heading is computed from rotation and speed...
    CGPoint speed = CGPointMake(0.0, self.speed);
    CGPoint val = CGPointApplyAffineTransform(speed, CGAffineTransformMakeRotation(-self.rotation * (3.141596 / 180.0)));
    
    return val;
}

- (void) update:(ccTime)dt
{
    [super update:dt];
    
    if (self.moveSelf)
    {
        float xFactor = self.heading.x * dt;
        float yFactor = self.heading.y * dt;
        CGPoint oldPos = self.position;
        self.position = CGPointMake(oldPos.x + xFactor, oldPos.y + yFactor);
    }
}


@end
