//
//  Z1GameOverOverlay.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/22/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1GameOverOverlay.h"

#define X_SQUARES 80
#define Y_SQUARES 60

@implementation Z1GameOverOverlay

- (id) init
{
    if (( self = [super init] ))
    {
        self.isKeyboardEnabled = YES;
        float xOffset = 15.0;
        float yOffset = 15.0;
        for (int x = 0; x < X_SQUARES; x++) 
        {
            for (int y = 0; y < Y_SQUARES; y++) 
            {
                // make a tile and place it
                CCSprite* aSquare = [CCSprite spriteWithFile:@"square.png"];
                aSquare.scale = 0.25f;
                aSquare.position = ccp(x * xOffset, y * yOffset);
                aSquare.opacity = 0.0;
                float time = (arc4random() % 100) / 15.0;
                CCFadeIn* fadeAction = [CCFadeIn actionWithDuration:time];
                CCDelayTime* delayAction = [CCDelayTime actionWithDuration:1.0];
                [aSquare runAction:[CCSequence actions:delayAction, fadeAction, nil]];
                [self addChild:aSquare];
            }
        }
    }
    return self;
}

- (BOOL) ccKeyDown:(NSEvent *)event
{
    [[CCDirector sharedDirector] popScene];
    return YES;
}

@end
