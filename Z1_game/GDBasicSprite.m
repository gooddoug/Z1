//
//  GDBasicSprite.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/6/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDBasicSprite.h"


@implementation GDBasicSprite

@synthesize speed = _speed, time = _time, sprite = _sprite, animBlock, animInfo = _animInfo, dead, currentFrame = _currentFrame, heading = _heading, scaleDirection = _scaleDirection;

+ (GDBasicSprite*) spriteWithFile:(NSString*)inFilename
{
    return [[[GDBasicSprite alloc] initWithFile:inFilename] autorelease];
}

+ (GDBasicSprite*) spriteWithDict:(NSDictionary*)inDict
{
    NSString* name = [inDict objectForKey:@"name"];
    if (!name)
    {
        name = @"ship1.png";
    }
    GDBasicSprite* val = [GDBasicSprite spriteWithFile:name];
    if ([inDict objectForKey:@"scale"]) 
    {
        val.scale = [[inDict objectForKey:@"scale"] floatValue];
    }
    if ([inDict objectForKey:@"initialSpeed"])
    {
        val.speed = [[inDict objectForKey:@"initialSpeed"] floatValue];
        
    }

    return val;
}

- (id) init
{
    if ((self = [super init]))
    {
        [self scheduleUpdate];
    }
    return self;
}

- (id) initWithFile:(NSString*)inFilename
{
    if ((self = [self init]))
    {
        self.sprite = [CCSprite spriteWithFile:inFilename];
        [self addChild:self.sprite];
        CGSize size = [[CCDirector sharedDirector] winSize];
        CGPoint center = ccp( size.width /2 , size.height/2 );
        self.position = center;
        self.contentSize = self.sprite.contentSize;
        float anchorFactor = (size.height / self.sprite.contentSize.height) + 1;
        self.anchorPoint = ccp( 0.5 , anchorFactor );
    }
    
    return self;
}

- (void) dealloc
{
    [_sprite release];
    [_animInfo release];
    [animBlock release];
    
    [super dealloc];
}

- (void) update:(ccTime)dt
{
    // need to schedule update
    // subclasses need to call this at the end to move unless they handle their own movement
    self.time = self.time + dt;
    // first, run our animBlock
    if (self.animBlock)
        self.animBlock(dt, self);
}


@end
