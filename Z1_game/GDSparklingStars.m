//
//  GDSparklingStars.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/28/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDSparklingStars.h"

#define DEFAULT_HOW_MANY 300
#define DEFAULT_SPEED 2

@implementation GDSparklingStars

- (id) initWithEffectDictionary:(NSDictionary*)inDict
{
    if (( self = [super init] ))
    {
        int howMany = [[inDict valueForKey:@"howMany"] intValue];
        if (!howMany)
        {
            howMany = DEFAULT_HOW_MANY;
        }
        float speed = [[inDict valueForKey:@"speed"] floatValue];
        if (!speed)
        {
            speed = DEFAULT_SPEED;
        }
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.contentSize = size;
        
        // for each, create a random point, random twinkle value
        CCToggleVisibility* visibilityAction = [CCToggleVisibility action];
        for (int i = 0; i < howMany; i++) 
        {
            CCSprite* aStar = [CCSprite spriteWithFile:@"stars.png"];
            float x = (1.0 / (float)arc4random()) * size.width;
            float y = (1.0 / (float)arc4random()) * size.height;
            float blinkOnDelay = (1.0 / (float)arc4random()) * 4.0 + 1;
            float blinkOffDelay = (1.0 / (float)arc4random()) * 2.0;
            float scale = (1.0 / (float)arc4random()) * 0.5;
            BOOL visible = (arc4random() % 4) < 3;
            aStar.position = ccp(x, y);
            aStar.scale = scale;
            aStar.visible = visible;
            CCDelayTime* blinkOnDelayAction = [CCDelayTime actionWithDuration:blinkOnDelay];
            CCDelayTime* blinkOffDelayAction = [CCDelayTime actionWithDuration:blinkOffDelay];
            CCRepeatForever* repeatAction = [CCRepeatForever actionWithAction:[CCSequence actions:blinkOffDelayAction, visibilityAction, blinkOnDelayAction, visibilityAction, nil]];
            [aStar runAction:repeatAction];
            [self addChild:aStar z:2];
        }
        [self scheduleUpdate];
    }
    return self;
}

- (void) update:(ccTime)dt
{
    // move the stars out slowly
    
}

@end
