//
//  GDMenuScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1MenuScreen.h"
#import "Z1CreditsScreen.h"
#import "Z1EndScreen.h"
#import "Z1GameMenuScreen.h"
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
    if ((self = [self initWithEffectNames:[NSArray arrayWithObjects:@"GDParticleGalaxy", nil]] ))
    {
        for (NSString* name in [NSArray arrayWithObjects:@"Hartland Regular", @"Hartland", @"Helvetica", nil]) 
        {
            NSFont* aFont = [[NSFontManager sharedFontManager] fontWithFamily:name traits:NSUnboldFontMask | NSUnitalicFontMask weight:0 size:32];
            if (!aFont)
            {
                NSLog(@"Couldn't get a Font for %@", name);
            }
        }
        
        // now add buttons
        CCLabelTTF* menuLabelPlay = [CCLabelTTF labelWithString:@"Play" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemPlay = [CCMenuItemLabel itemWithLabel:menuLabelPlay block:^(id sender)
                                       {
                                           CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                                                         scene:[Z1GameMenuScreen scene]
                                                                                                     withColor:ccWHITE];
                                           [[CCDirector sharedDirector] pushScene:trans];
                                       }];
        CCLabelTTF* menuLabelQuit = [CCLabelTTF labelWithString:@"Quit" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemQuit = [CCMenuItemLabel itemWithLabel:menuLabelQuit block:^(id sender)
                                       {
                                           CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                                                         scene:[Z1EndScreen scene]
                                                                                                     withColor:ccWHITE];
                                           [[CCDirector sharedDirector] pushScene:trans];
                                           [[GDSoundsManager sharedSoundsManager] playSoundForName:SCREEN_TRANSITION];
                                       }];
        
        CCLabelTTF* menuLabelUDG = [CCLabelTTF labelWithString:@"uDevGames" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemUDG = [CCMenuItemLabel itemWithLabel:menuLabelUDG block:^(id sender)
                                      {
                                          [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.udevgames.com"]];
                                      }];
        
        CCLabelTTF* menuLabelCredits = [CCLabelTTF labelWithString:@"Credits" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemCredits = [CCMenuItemLabel itemWithLabel:menuLabelCredits block:^(id sender)
                                            {
                                                CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                                                             scene:[Z1CreditsScreen scene]
                                                                                                         withColor:ccWHITE];
                                                [[CCDirector sharedDirector] pushScene:trans];
                                                [[GDSoundsManager sharedSoundsManager] playSoundForName:SCREEN_TRANSITION];
                                            }];
        
        CCMenu* aMenu = [CCMenu menuWithItems:menuItemPlay, menuItemUDG, menuItemQuit, menuItemCredits, nil];
		[aMenu alignItemsVerticallyWithPadding:30];
        self.isMouseEnabled = YES;
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        aMenu.position = ccp(800.0f, 295.0f);
        [self addChild:aMenu z:10];
        
        CCSprite* background = [CCSprite spriteWithFile:@"ui-screen.png"];
        background.position = ccp(size.width / 2.0, size.height / 2.0);
        [self addChild:background z:0];

    }
    return self;
}

@end
