//
//  Z1MessageOverlay.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/23/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1MessageOverlay.h"

@interface Z1MessageOverlay ()

@property (nonatomic, retain, readonly) CCSprite* monitor;

@end

@implementation Z1MessageOverlay

@synthesize showing = _showing;

- (id) initWithText:(NSString*)inMessage
{
    if (( self = [super init] ))
    {
        self.showing = NO;
    }
    return self;
}

#pragma mark Accessors

- (NSString*) text
{
    return _text;
}

- (void) setText:(NSString *)text
{
    [text retain];
    [_text release];
    _text = text;
    // now set the text sprite
}

- (CCSprite*) monitor
{
    if (!_monitor)
    {
        _monitor = [CCSprite spriteWithFile:@"monitor.png"];
        float xPos = 1324 - _monitor.contentSize.width;
        float yPos = 768 + _monitor.contentSize.height;
        _monitor.position = ccp(xPos, yPos);
        [self addChild:_monitor z:210];
    }
    return _monitor;
}

- (void) show
{
    if (self.showing)
        return;
    CCMoveBy* moveAnimation = [CCMoveBy actionWithDuration:1.0 position:ccp(0.0, -(self.monitor.contentSize.height + 200))];
    [self.monitor runAction:moveAnimation];
    self.showing = YES;
}

- (void) hide
{
    if (!self.showing)
        return;
    CCMoveBy* moveAnimation = [CCMoveBy actionWithDuration:1.0 position:ccp(0.0, self.monitor.contentSize.height + 200)];
    [self.monitor runAction:moveAnimation];
    self.showing = NO;
}

- (void) toggle
{
    if (self.showing)
    {
        [self hide];
    } else
    {
        [self show];
    }
}

@end
