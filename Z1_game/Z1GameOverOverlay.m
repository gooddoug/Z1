//
//  Z1GameOverOverlay.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/22/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1GameOverOverlay.h"
#import "SimpleAudioEngine.h"
#import "GDSoundsManager.h"
#import "Z1GameScreen.h"

#define X_SQUARES 80
#define Y_SQUARES 60

@implementation Z1GameOverOverlay

@synthesize showing, waiting;

- (id) initAndFinsihed:(BOOL)finished
{
    if (( self = [super init] ))
    {
        [[GDSoundsManager sharedSoundsManager] playMusicForSceneNamed:@"gameOver"];
        self.isKeyboardEnabled = YES;
        self.waiting = YES;
        float xOffset = 15.0;
        float yOffset = 15.0;
        for (int x = 0; x < X_SQUARES; x++) 
        {
            for (int y = 0; y < Y_SQUARES; y++) 
            {
                // make a tile and place it
                CCSprite* aSquare = [CCSprite spriteWithFile:@"red-square.png"];
                aSquare.scale = 0.25f;
                aSquare.position = ccp(x * xOffset, y * yOffset);
                aSquare.opacity = 0.0;
                float time = (arc4random() % 100) / 20.0;
                CCFadeIn* fadeAction = [CCFadeIn actionWithDuration:time];
                CCDelayTime* delayAction = [CCDelayTime actionWithDuration:1.0];
                [aSquare runAction:[CCSequence actions:delayAction, fadeAction, nil]];
                [self addChild:aSquare];
                
            }
        }
        // now add the screen
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite* gameOverBackground = [CCSprite spriteWithFile:@"game-over.png"];
        gameOverBackground.position = ccp(size.width / 2.0, size.height / 2.0);
        gameOverBackground.opacity = 0.0;
        
        CCFadeIn* fadeBackAction = [CCFadeIn actionWithDuration:2.0];
        CCDelayTime* delayBackAction = [CCDelayTime actionWithDuration:3.0];
        CCCallBlock* stopWaitingAction = [CCCallBlock actionWithBlock:^{
            self.waiting = NO;
        }];
        [gameOverBackground runAction:[CCSequence actions:delayBackAction, fadeBackAction, stopWaitingAction, nil]];
        [self addChild:gameOverBackground];
        
        // add press any key label
        CCLabelTTF* pressKeyLabel = [CCLabelTTF labelWithString:@"Press any key" fontName:@"Helvetica" fontSize:48];
        pressKeyLabel.position = ccp(size.width / 2.0, 60.0);
        pressKeyLabel.opacity = 0.0;
        CCFadeIn* fadeAction = [CCFadeIn actionWithDuration:1.0];
        CCDelayTime* delayAction = [CCDelayTime actionWithDuration:7.5];
        [pressKeyLabel runAction:[CCSequence actions:delayAction, fadeAction, nil]];
        [self addChild:pressKeyLabel z:10];
        
        if (finished)
        {
            CCSprite* gameWonBackground = [CCSprite spriteWithFile:@"ending-credits.png"];
            gameWonBackground.position = ccp(size.width / 2.0, size.height / 2.0);
            gameWonBackground.opacity = 0.0;
            
            CCFadeIn* fadeBackAction = [CCFadeIn actionWithDuration:1.0];
            CCDelayTime* delayBackAction = [CCDelayTime actionWithDuration:5.0];
            [gameWonBackground runAction:[CCSequence actions:delayBackAction, fadeBackAction, nil]];
            [self addChild:gameWonBackground];
        }
                
        self.showing = YES;
    }
    return self;
}
         
- (BOOL) ccKeyDown:(NSEvent *)event
{
    if (self.waiting)
        return NO;
    if(self.showing)
    {
        self.showing = NO;
        [(Z1GameScreen*)self.parent moveOn:self];
        return YES;
    }
    return NO;
}

@end
