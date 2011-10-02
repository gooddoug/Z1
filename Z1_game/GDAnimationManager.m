//
//  GDAnimationManager.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/19/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDAnimationManager.h"
#import "Z1Player.h"

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
            
             aSprite.scale = aSprite.scale + (dt * 0.1);
             
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
        
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             if (!aSprite.animInfo) 
             {
                 aSprite.anchorPoint = ccp( 0.5 , 6.5 );
                 aSprite.scale = 1.0;
                 
                 aSprite.animInfo = [NSNumber numberWithFloat:0.0];
             }
             aSprite.animInfo = [NSNumber numberWithFloat:[aSprite.animInfo floatValue] + dt];
             float playerRot = [Z1Player sharedPlayer].sprite.rotation;
             float escortRot = aSprite.rotation;
             if (playerRot > 270.0 && escortRot < 100.0)
             {
                 escortRot = escortRot + 360;
                 //NSLog(@"p:%f e:%f escort +", playerRot, escortRot);
             }
             if (playerRot < 100.0 && escortRot > 270.0)
             {
                 //NSLog(@"p:%f e:%f escort -", playerRot, escortRot);
                 escortRot = escortRot - 360;
             }
             float diff = playerRot - escortRot;
             
             float rotFactor = 70 * dt;
             if (diff > 45)
             {
                 rotFactor = 130 * dt;
             }
             float factor = (diff < 0.0) ? -1.0 : 1.0;
             
             if (abs(diff) > rotFactor)
             {
                 // rotate 70
                 aSprite.rotation = aSprite.rotation + factor * rotFactor;
             } else {
                 aSprite.rotation = aSprite.rotation + diff;
             }
             
             if ([aSprite.animInfo floatValue] > 58.0)
             {
                 aSprite.scale = aSprite.scale - (0.1 * dt);
                 if (aSprite.scale < 0.0)
                 {
                     aSprite.dead = YES;
                     aSprite.scale = 0.0;
                 }
             }
         } forKey:@"FollowPlayer"];
        
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             float scaleFactor = 0.1;
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
             if (aSprite.scale > 0.25)
             {
                 float playerRot = [Z1Player sharedPlayer].sprite.rotation;
                 float enemyRot = aSprite.rotation;
                 if (playerRot > 270.0 && enemyRot < 100.0)
                 {
                     enemyRot = enemyRot + 360;
                     //NSLog(@"p:%f e:%f escort +", playerRot, enemyRot);
                 }
                 if (playerRot < 100.0 && enemyRot > 270.0)
                 {
                     //NSLog(@"p:%f e:%f escort -", playerRot, enemyRot);
                     enemyRot = enemyRot - 360;
                 }
                 float diff = playerRot - enemyRot;
                 
                 float rotFactor = aSprite.speed * dt;
                 if (diff > 45)
                 {
                     rotFactor = aSprite.speed * 2 * dt;
                 }
                 float factor = (diff < 0.0) ? -1.0 : 1.0;
                 
                 if (abs(diff) > rotFactor)
                 {
                     // rotate 70
                     aSprite.rotation = aSprite.rotation + factor * rotFactor;
                 } else {
                     aSprite.rotation = aSprite.rotation + diff;
                 }
             }
             else 
             {
                 aSprite.rotation = aSprite.rotation - (dt * aSprite.speed);
             }
             aSprite.scale = aSprite.scale + (dt * scaleFactor);
        } forKey:@"SpiralOutCounterClockwiseAndAttack"];
        
        [blockDict setObject:^(ccTime dt, GDBasicSprite* aSprite)
         {
             float scaleFactor = 0.1;
             if (aSprite.scale >= 2.0)
             {
                 aSprite.dead = YES;
             }
             if (aSprite.scale > 0.25)
             {
                 float playerRot = [Z1Player sharedPlayer].sprite.rotation;
                 float enemyRot = aSprite.rotation;
                 if (playerRot > 270.0 && enemyRot < 100.0)
                 {
                     enemyRot = enemyRot + 360;
                     //NSLog(@"p:%f e:%f escort +", playerRot, enemyRot);
                 }
                 if (playerRot < 100.0 && enemyRot > 270.0)
                 {
                     //NSLog(@"p:%f e:%f escort -", playerRot, enemyRot);
                     enemyRot = enemyRot - 360;
                 }
                 float diff = playerRot - enemyRot;
                 
                 float rotFactor = aSprite.speed * dt;
                 if (diff > 45)
                 {
                     rotFactor = aSprite.speed * 2 * dt;
                 }
                 float factor = (diff < 0.0) ? -1.0 : 1.0;
                 
                 if (abs(diff) > rotFactor)
                 {
                     // rotate 70
                     aSprite.rotation = aSprite.rotation + factor * rotFactor;
                 } else {
                     aSprite.rotation = aSprite.rotation + diff;
                 }
             }
             else 
             {
                 aSprite.rotation = aSprite.rotation + (dt * aSprite.speed);
             }
             aSprite.scale = aSprite.scale + (dt * scaleFactor);
             
         } forKey:@"SpiralOutClockwiseAndAttack"];
        
        // log the names of the animations
        /*for (NSString* aKey in [blockDict keyEnumerator]) 
        {
            NSLog(@"%@\n", aKey);
        }*/
        
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
