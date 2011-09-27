//
//  GDAnimationManager.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/19/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDAnimationManager.h"


@implementation GDAnimationManager

@synthesize animations = _animations;

static GDAnimationManager* _animationManager = nil;

+ (GDAnimationManager*) sharedAnimationManager
{
    if (!_animationManager)
    {
        _animationManager = [[GDAnimationManager alloc] init];
        NSMutableDictionary* blockDict = [NSMutableDictionary dictionary];
        
        // FigureEight
        [blockDict setObject:^(ccTime dt, GDUnboundSprite* aSprite)
         {
             if (aSprite.time > 10.0)
             {
                 aSprite.dead = YES;
             }
             if (!aSprite.animInfo)
             {
                 aSprite.animInfo = [NSNumber numberWithInt:1];
             }
             // update the enemy by changing rotation by a fixed amount
             if (aSprite.rotation >= 360)
             {
                 aSprite.animInfo = [NSNumber numberWithInt:-1];
             } else if (aSprite.rotation <= 0)
             {
                 aSprite.animInfo = [NSNumber numberWithInt:1];
             }
             aSprite.rotation = aSprite.rotation + ([aSprite.animInfo intValue] * 2);
             aSprite.scale = aSprite.scale + (0.001 * [aSprite.animInfo intValue]);
         } forKey:@"FigureEight"];
        
        // simple spiral
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             if (aSprite.scale <= 0.01)
             {
                 aSprite.dead = YES;
             }
             // I want the sprite to be slightly aimed in... and for the scale to be related to how close to the center of the screen it is
             if (!aSprite.animInfo)
             {
                 
             }
             aSprite.scale = aSprite.scale - (dt * 0.1);
             aSprite.rotation = aSprite.rotation + (dt * aSprite.speed);
             
         } forKey:@"SimpleSpiralInClockwise"];
        
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             if (aSprite.scale <= 0.01)
             {
                 aSprite.dead = YES;
             }
             // I want the sprite to be slightly aimed in... and for the scale to be related to how close to the center of the screen it is
             if (!aSprite.animInfo)
             {
                 
             }
             aSprite.scale = aSprite.scale - (dt * 0.1);
             aSprite.rotation = aSprite.rotation - (dt * aSprite.speed);
             
         } forKey:@"SimpleSpiralInCounterClockwise"];
        // simple spiral
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
             // I want the sprite to be slightly aimed in... and for the scale to be related to how close to the center of the screen it is
             if (!aSprite.animInfo)
             {
                 
             }
             aSprite.scale = aSprite.scale + (dt * 0.1);
             aSprite.rotation = aSprite.rotation + (dt * aSprite.speed);
             
         } forKey:@"SimpleSpiralOutClockwise"];
        
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
             // I want the sprite to be slightly aimed in... and for the scale to be related to how close to the center of the screen it is
             if (!aSprite.animInfo)
             {
                 
             }
             aSprite.scale = aSprite.scale + (dt * 0.1);
             aSprite.rotation = aSprite.rotation - (dt * aSprite.speed);
             
         } forKey:@"SimpleSpiralOutCounterClockwise"];
        
        // spiral in and out again
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             if (!aSprite.animInfo)
             {
                 aSprite.animInfo = [NSNumber numberWithInt:-1];
             }
             
             if (aSprite.scale <= 0.1)
             {
                 aSprite.animInfo = [NSNumber numberWithInt:1];
             }
             
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
             int factor = [aSprite.animInfo intValue];
             
             aSprite.scale = aSprite.scale + (dt * 0.25 * factor);
             aSprite.rotation = aSprite.rotation + (dt * aSprite.speed);
             
         } forKey:@"SpiralInAndOutClockwise"];
        
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             if (!aSprite.animInfo)
             {
                 aSprite.animInfo = [NSNumber numberWithInt:-1];
             }
             
             if (aSprite.scale <= 0.1)
             {
                 aSprite.animInfo = [NSNumber numberWithInt:1];
             }
             
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
             int factor = [aSprite.animInfo intValue];
             
             aSprite.scale = aSprite.scale + (dt * 0.25 * factor);
             aSprite.rotation = aSprite.rotation - (dt * aSprite.speed);
             
         } forKey:@"SpiralInAndOutCounterClockwise"];
        
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
            
             aSprite.scale = aSprite.scale + (dt * 0.25);
             
         } forKey:@"ZoomOut"];
        
        // zoom out and circle
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             float scaleFactor = 0.1;
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
             if (aSprite.scale <= 0.25 && aSprite.scale > 0.2)
             {
                 scaleFactor = 0.01;
             }
             // I want the sprite to be slightly aimed in... and for the scale to be related to how close to the center of the screen it is
             if (!aSprite.animInfo)
             {
                 
             }
             aSprite.scale = aSprite.scale + (dt * scaleFactor);
             aSprite.rotation = aSprite.rotation + (dt * aSprite.speed);
             
         } forKey:@"SpiralOutClockwiseAndCircle"];
        
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             float scaleFactor = 0.1;
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
             if (aSprite.scale <= 0.25 && aSprite.scale > 0.2)
             {
                 scaleFactor = 0.01;
             }
             // I want the sprite to be slightly aimed in... and for the scale to be related to how close to the center of the screen it is
             if (!aSprite.animInfo)
             {
                 
             }
             aSprite.scale = aSprite.scale + (dt * scaleFactor);
             aSprite.rotation = aSprite.rotation - (dt * aSprite.speed);
             
         } forKey:@"SpiralOutCounterClockwiseAndCircle"];
        
        // log the names of the animations
        /*for (NSString* aKey in [blockDict keyEnumerator]) 
        {
            NSLog(@"%@\n", aKey);
        }
        */
        _animationManager.animations = [NSDictionary dictionaryWithDictionary:blockDict];
    }
    return _animationManager;
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.animations = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_animations release];
    
    [super dealloc];
}

- (AnimBlock) movementAnimationForKey:(NSString*)key
{
    return [self.animations objectForKey:key];
}

@end
