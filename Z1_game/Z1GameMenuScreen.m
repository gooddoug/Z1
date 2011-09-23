//
//  Z1GameMenuScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/16/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1GameMenuScreen.h"
#import "Z1LevelManager.h"
#import "Z1Player.h"


@implementation Z1GameMenuScreen

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	
	Z1GameMenuScreen *layer = [Z1GameMenuScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

- (id) init
{
    if ((self = [self initWithEffectNames:[NSArray array]] ))
    {
        // now add buttons
        CCLabelTTF* menuLabelRestart = [CCLabelTTF labelWithString:@"New Game" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemRestart = [CCMenuItemLabel itemWithLabel:menuLabelRestart block:^(id sender)
                                         {
                                             // zero out the score and lastLevel
                                             [[Z1Player sharedPlayer] resetPlayer];
                                             CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                                                           scene:[[Z1LevelManager sharedLevelManager] levelSceneAtIndex:0]
                                                                                                       withColor:ccWHITE];
                                             [[CCDirector sharedDirector] pushScene:trans];
                                         }];
        CCLabelTTF* menuLabelStartFromLast = [CCLabelTTF labelWithString:@"Resume" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemStartFromLast = [CCMenuItemLabel itemWithLabel:menuLabelStartFromLast block:^(id sender)
                                         {
                                             CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                                                           scene:[[Z1LevelManager sharedLevelManager] levelSceneAtIndex:[Z1Player sharedPlayer].lastLevel + 1] 
                                                                                                       withColor:ccWHITE];
                                             [[CCDirector sharedDirector] pushScene:trans];
                                         }];
        CCLabelTTF* menuLabelBack = [CCLabelTTF labelWithString:@"Back" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemBack = [CCMenuItemLabel itemWithLabel:menuLabelBack block:^(id sender)
                                         {
                                             [[CCDirector sharedDirector] popScene]; 
                                         }];
        
        CCLabelTTF* menuLabelEmpty = [CCLabelTTF labelWithString:@"_" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemEmpty = [CCMenuItemLabel itemWithLabel:menuLabelEmpty block:^(id sender)
                                         {
                                             [[CCDirector sharedDirector] popScene]; 
                                         }];

        CCMenu* aMenu = [CCMenu menuWithItems:menuItemRestart, menuItemStartFromLast, menuItemBack, menuItemEmpty, nil];
		[aMenu alignItemsVerticallyWithPadding:30];
        self.isMouseEnabled = YES;
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        aMenu.position = ccp(800.0f, 295.0f);
        [self addChild:aMenu z:10];
        
        CCSprite* background = [CCSprite spriteWithFile:@"ui-screen.png"];
        [background setScale:1.0];
        background.position = ccp(size.width / 2.0, size.height / 2.0);
        [self addChild:background z:0];
    }
    
    return self;
}

@end
