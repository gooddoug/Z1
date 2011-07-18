//
//  GDBaseEffectsScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDBaseEffectsScreen.h"


@implementation GDBaseEffectsScreen

@synthesize effects = _effects;

- (id) initWithEffectNames:(NSArray*)inNames
{
    NSMutableArray* effects = [NSMutableArray arrayWithCapacity:[inNames count]];
    for (NSString* aName in inNames) 
    {
        [effects addObject:[[[NSClassFromString(aName) alloc] init] autorelease]];
    }
    return [self initWithEffects:effects];
}

- (id) initWithEffects:(NSArray*)inEffects
{
    if ((self = [super init]))
    {
        self.effects = inEffects;
    }
    return self;
}

- (void) dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [_effects release];
    
    [super dealloc];
}

- (void) setEffects:(NSArray *)effects
{
    if (effects == _effects)
    {
        return;
    }
    NSArray* temp = [effects retain];
    [_effects release];
    _effects = temp;
    // remove old children
    [self removeAllChildrenWithCleanup:YES];
    // add them as children
    int i = 0;
    for (CCNode* aNode in _effects) 
    {
        [self addChild:aNode z:i];
        i++;
    }
}

- (NSArray*) effects
{
    return _effects;
}

@end
