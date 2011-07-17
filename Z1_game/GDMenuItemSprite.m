//
//  GDMenuItemSprite.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/6/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDMenuItemSprite.h"

// my own class for handling animating when mouse over

@implementation GDMenuItemSprite

-(id) initFromNormalSprite:(CCNode<CCRGBAProtocol>*)normalSprite selectedSprite:(CCNode<CCRGBAProtocol>*)selectedSprite disabledSprite:(CCNode<CCRGBAProtocol>*)disabledSprite block:(void(^)(id sender))block
{
    if ((self = [super initFromNormalSprite:normalSprite selectedSprite:selectedSprite disabledSprite:disabledSprite block:block]))
    {
        [[CCEventDispatcher sharedDispatcher] addMouseDelegate:self priority:0];
    }
    return self;
}

- (void) ccMouseEntered:(NSEvent*)event
{
    NSLog(@"Mouse Entered");
}

- (void) ccMouseExited:(NSEvent*)event
{
    NSLog(@"Mouse exited");
}

@end
