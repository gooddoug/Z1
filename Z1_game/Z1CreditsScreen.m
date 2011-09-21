//
//  Z1CreditsScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/18/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1CreditsScreen.h"
#import "GDScrollingText.h"


@implementation Z1CreditsScreen

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	
	Z1CreditsScreen *layer = [Z1CreditsScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

- (id) init
{
    if (( self = [super initWithEffectNames:[NSArray arrayWithObjects:@"GDParticleStarfield", @"GDParticleFog", nil]] ))
    {
        self.isKeyboardEnabled = YES;
        
        GDScrollingText* scrollingText = [[[GDScrollingText alloc] initWithFile:[[NSBundle mainBundle] pathForResource:@"credits" ofType:@"txt"]] autorelease];
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        scrollingText.position = ccp(size.width / 2.0, size.height / 2.0);
        [self addChild:scrollingText z:20];

		CCSprite* background = [CCSprite spriteWithFile:@"credits.png"];
        background.position = ccp(size.width / 2, size.height /2);
        [self addChild:background z:1];
        
        CCLabelTTF* menuLabelUDG = [CCLabelTTF labelWithString:@"uDevGames" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemUDG = [CCMenuItemLabel itemWithLabel:menuLabelUDG block:^(id sender)
                                        {
                                            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.udevgames.com"]];
                                        }];
        CCLabelTTF* menuLabelBack = [CCLabelTTF labelWithString:@"Back" fontName:@"Helvetica" fontSize:32];
        CCMenuItemLabel* menuItemBack = [CCMenuItemLabel itemWithLabel:menuLabelBack block:^(id sender)
                                         {
                                            [[CCDirector sharedDirector] popScene]; 
                                         }];
        CCMenu* aMenu = [CCMenu menuWithItems:menuItemUDG, menuItemBack, nil];
		[aMenu alignItemsVertically];
        self.isMouseEnabled = YES;
        
        aMenu.position = ccp(900.0f, size.height / 2.0);
        [self addChild:aMenu z:10];
    }
    return self;
}

- (BOOL) ccKeyUp:(NSEvent *)event
{
    
    [[CCDirector sharedDirector] popScene];
    
    return YES;
}

@end
