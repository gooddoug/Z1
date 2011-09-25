//
//  GDMenuScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1MenuScreen.h"
#import "Z1EndScreen.h"
#import "Z1GameMenuScreen.h"
#import "Z1Player.h"
#import "Z1LevelManager.h"
#import "GDSoundsManager.h"

@implementation Z1MenuScreen

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	
	Z1MenuScreen *layer = [Z1MenuScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

- (id) init
{
    if ((self = [super initWithEffectNames:[NSArray array]] ))
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        // add background image
        CCSprite* background = [CCSprite spriteWithFile:@"main-menu.png"];
        background.position = ccp(size.width / 2.0, size.height / 2.0);
        [self addChild:background z:0];
        
        // add buttons...
        // start
        CCSprite* startButtonSprite = [CCSprite spriteWithFile:@"start-button.png"];
        CCSprite* startButtonSpriteSelected = [CCSprite spriteWithFile:@"start-button.png"]; // same for now
        startButtonSpriteSelected.scale = 1.15;
        CCMenuItemSprite* startButton = [CCMenuItemSprite itemFromNormalSprite:startButtonSprite selectedSprite:startButtonSpriteSelected block:^(id sender)
                                         {
                                             CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                                                           scene:[[Z1LevelManager sharedLevelManager] levelSceneAtIndex:[Z1Player sharedPlayer].lastLevel + 1] 
                                                                                                       withColor:ccWHITE];
                                             [[CCDirector sharedDirector] pushScene:trans];
                                         }];
        
        // restart
        CCSprite* restartButtonSprite = [CCSprite spriteWithFile:@"restart-button.png"];
        CCSprite* restartButtonSpriteSelected = [CCSprite spriteWithFile:@"restart-button.png"]; // same for now
        restartButtonSpriteSelected.scale = 1.15;
        CCMenuItemSprite* restartButton = [CCMenuItemSprite itemFromNormalSprite:restartButtonSprite selectedSprite:restartButtonSpriteSelected block:^(id sender)
                                           {
                                               // zero out the score and lastLevel
                                               [[Z1Player sharedPlayer] resetPlayer];
                                               CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                                                             scene:[[Z1LevelManager sharedLevelManager] levelSceneAtIndex:0]
                                                                                                         withColor:ccWHITE];
                                               [[CCDirector sharedDirector] pushScene:trans];
                                           }];
        
        // credits
        CCSprite* creditsButtonSprite = [CCSprite spriteWithFile:@"credits-button.png"];
        CCSprite* creditsButtonSpriteSelected = [CCSprite spriteWithFile:@"credits-button.png"]; // same for now
        creditsButtonSpriteSelected.scale = 1.15;
        CCMenuItemSprite* creditsButton = [CCMenuItemSprite itemFromNormalSprite:creditsButtonSprite selectedSprite:creditsButtonSpriteSelected block:^(id sender)
                                           {
                                               if (self.messageOverlay.showing)
                                               {
                                                   [self.messageOverlay hide];
                                               }
                                               else
                                               {
                                                   NSString* creditsPath = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"txt"];
                                                   NSString* creditsText = [NSString stringWithContentsOfFile:creditsPath encoding:NSUTF8StringEncoding error:nil];
                                                   self.messageOverlay.text = creditsText;
                                                   [self.messageOverlay show];
                                                   double delayInSeconds = 20.0;
                                                   dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                                   dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                       [self.messageOverlay hide];
                                                   });
                                                   [[GDSoundsManager sharedSoundsManager] playSoundForName:SCREEN_TRANSITION];
                                               }
                                           }];
        
        // vote
        CCSprite* voteButtonSprite = [CCSprite spriteWithFile:@"vote-button.png"];
        CCSprite* voteButtonSpriteSelected = [CCSprite spriteWithFile:@"vote-button.png"]; // same for now
        voteButtonSpriteSelected.scale = 1.15;
        CCMenuItemSprite* voteButton = [CCMenuItemSprite itemFromNormalSprite:voteButtonSprite selectedSprite:voteButtonSpriteSelected block:^(id sender)
                                        {
                                            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.udevgames.com"]];
                                        }];
        
        // options // CHANGE THIS ONCE WE GET NEW STUFF
        CCSprite* optionsButtonSprite = [CCSprite spriteWithFile:@"options-button.png"];
        CCSprite* optionsButtonSpriteSelected = [CCSprite spriteWithFile:@"options-button.png"]; // same for now
        optionsButtonSpriteSelected.scale = 1.15;
        CCMenuItemSprite* optionsButton = [CCMenuItemSprite itemFromNormalSprite:optionsButtonSprite selectedSprite:optionsButtonSpriteSelected block:^(id sender)
                                        {
                                            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.udevgames.com"]];
                                        }];
        
        // quit // CAHNGE THIS TO USE OVERLAY AND THEN QUIT
        CCSprite* quitButtonSprite = [CCSprite spriteWithFile:@"quit-button.png"];
        CCSprite* quitButtonSpriteSelected = [CCSprite spriteWithFile:@"quit-button-selected.png"]; // same for now
        CCMenuItemSprite* quitButton = [CCMenuItemSprite itemFromNormalSprite:quitButtonSprite selectedSprite:quitButtonSpriteSelected block:^(id sender)
                                        {
                                            if (self.messageOverlay.showing)
                                            {
                                                [self.messageOverlay hide];
                                            }
                                            else
                                            {
                                                NSString* creditsPath = [[NSBundle mainBundle] pathForResource:@"end" ofType:@"txt"];
                                                NSString* creditsText = [NSString stringWithContentsOfFile:creditsPath encoding:NSUTF8StringEncoding error:nil];
                                                self.messageOverlay.text = creditsText;
                                                [self.messageOverlay show];
                                                double delayInSeconds = 5.0;
                                                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                    [self.messageOverlay hide];
                                                    [NSApp terminate:self];
                                                });
                                                [[GDSoundsManager sharedSoundsManager] playSoundForName:SCREEN_TRANSITION];
                                            }
                                        }];
        
        
        // create the menu
        CCMenu* aMenu = [CCMenu menuWithItems:startButton, restartButton, creditsButton, voteButton, optionsButton, quitButton, nil];
        //[aMenu alignItemsVertically];
        aMenu.position = ccp(600.0, 80.0);
        
        // now position each button
        startButton.position = ccp(85.0, 500.0);
        restartButton.position = ccp(115.0, 435.0);
        creditsButton.position = ccp(140.0, 370.0);
        voteButton.position = ccp(115.0, 305.0);
        optionsButton.position = ccp(85.0, 240.0);
        
        quitButton.position = ccp(390.0, -25.0);
        
        self.isMouseEnabled = YES;
        [self addChild:aMenu z:10];
    }
    return self;
}

- (Z1MessageOverlay*) messageOverlay
{
    if (!_messageOverlay)
    {
        _messageOverlay = [[Z1MessageOverlay alloc] initWithText:@"Hello World!"];
        [self addChild:_messageOverlay z:200];
    }
    return _messageOverlay;
}

#pragma mark key responders

- (BOOL) ccKeyUp:(NSEvent *)event
{
    if (_messageOverlay && self.messageOverlay.showing)
    {
        [self.messageOverlay hide];
    }
    return NO;
}

@end
