//
//  GDEnemyBase.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/5/11.
//  Copyright 2011 Doug Whitmore All rights reserved.
//

#import "GDEnemyBaseSprite.h"

@interface GDEnemyBaseSprite()

@end

@implementation GDEnemyBaseSprite

@synthesize speed = _speed, time = _time, sprite = _sprite, animBlock, animInfo = _animInfo, dead;

+ (GDEnemyBaseSprite*) spriteWithFile:(NSString*)inFilename
{
    return [[[GDEnemyBaseSprite alloc] initWithFile:inFilename] autorelease];
}

+ (GDEnemyBaseSprite*) spriteWithDict:(NSDictionary*)inDict
{
    NSString* name = [inDict objectForKey:@"name"];
    if (!name)
    {
        name = @"ship1.png";
    }
    GDEnemyBaseSprite* val = [GDEnemyBaseSprite spriteWithFile:name];
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
    // need to schedule update
    // subclasses need to call this at the end to move unless they handle their own movement
    self.time = self.time + dt;
    // first, run our animBlock
    if (self.animBlock)
        self.animBlock(dt, self);
    float xFactor = self.heading.x * dt;
    float yFactor = self.heading.y * dt;
    CGPoint oldPos = self.position;
    self.position = CGPointMake(oldPos.x + xFactor, oldPos.y + yFactor);
}

- (void) dealloc
{
    [_sprite release];
    [_animInfo release];
    [animBlock release];
    
    [super dealloc];
}

@end
