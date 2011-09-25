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
@property (nonatomic, retain) CCSprite* textSprite;

@end

@implementation Z1MessageOverlay

@synthesize showing = _showing, textSprite = _textSprite, text = _text;

- (id) initWithText:(NSString*)inMessage
{
    if (( self = [super init] ))
    {
        self.showing = NO;
        self.text = inMessage;
    }
    return self;
}

#pragma mark Accessors

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
    float howLong = 1.0;
    CCMoveBy* moveAnimation = [CCMoveBy actionWithDuration:howLong position:ccp(0.0, -(self.monitor.contentSize.height + 200))];
    [self.monitor runAction:moveAnimation];
    self.showing = YES;
    CCLabelTTF* textSprite = [CCLabelTTF labelWithString:self.text fontName:@"menlo" fontSize:10];
    textSprite.position = ccp(1324 - self.monitor.contentSize.width, 575);
    textSprite.opacity = 0.0;
    CCFadeIn* fadeInAction = [CCFadeIn actionWithDuration:0.25];
    CCDelayTime* delayAction = [CCDelayTime actionWithDuration:howLong];
    CCSequence* action = [CCSequence actionsWithArray:[NSArray arrayWithObjects:delayAction, fadeInAction, nil]];
    [textSprite runAction:action];
    self.textSprite = textSprite;
    [self addChild:self.textSprite z:220];
}

- (void) hide
{
    if (!self.showing)
        return;
    float howLong = 1.0;
    CCMoveBy* moveAnimation = [CCMoveBy actionWithDuration:howLong position:ccp(0.0, self.monitor.contentSize.height + 200)];
    [self.monitor runAction:moveAnimation];
    self.showing = NO;
    [self removeChild:self.textSprite cleanup:YES];
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
