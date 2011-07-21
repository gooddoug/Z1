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
        [blockDict setObject:^(ccTime dt, GDEnemyBaseSprite* aSprite)
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
             aSprite.scale = aSprite.scale + (0.002 * [aSprite.animInfo intValue]);
         } forKey:@"FigureEight"];
        
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
