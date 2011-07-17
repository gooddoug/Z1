//
//  GDButtonSprite.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/7/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDButtonSprite.h"


@implementation GDButtonSprite

- (void) ccMouseEntered:(NSEvent *)theEvent
{
    NSLog(@"Mouse entered");
}

- (void) ccMouseExited:(NSEvent *)theEvent
{
    NSLog(@"Mouse exited");
}

- (BOOL) ccMouseDown:(NSEvent *)event
{
    NSLog(@"Mouse down");
    return NO;
}

- (BOOL) ccMouseUp:(NSEvent *)event
{
    NSLog(@"Mouse up");
    return NO;
}


@end
