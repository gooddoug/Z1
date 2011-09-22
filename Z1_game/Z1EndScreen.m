//
//  Z1EndScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/18/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1EndScreen.h"
#import "GDScrollingText.h"

@implementation Z1EndScreen

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	
	Z1EndScreen *layer = [Z1EndScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

- (id) init
{
    if ((self = [self initWithEffectNames:[NSArray array]] ))
    {
        // add background later after checking stars
        self.isKeyboardEnabled = YES;
        GDScrollingText* scrollingText = [[[GDScrollingText alloc] initWithFile:[[NSBundle mainBundle] pathForResource:@"end" ofType:@"txt"]] autorelease];
        CGSize size = [[CCDirector sharedDirector] winSize];
        scrollingText.position = ccp(size.width / 2.0, size.height / 2.0);
        
        [self addChild:scrollingText z:20];
        
        CCLabelTTF* menuLabelUDG = [CCLabelTTF labelWithString:@"uDevGames" fontName:@"Nationalyze" fontSize:32];
        CCMenuItemLabel* menuItemUDG = [CCMenuItemLabel itemWithLabel:menuLabelUDG block:^(id sender)
                                        {
                                            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.udevgames.com"]];
                                            [NSApp terminate:self];
                                        }];
        CCLabelTTF* menuLabelBack = [CCLabelTTF labelWithString:@"Back" fontName:@"Nationalyze" fontSize:32];
        CCMenuItemLabel* menuItemBack = [CCMenuItemLabel itemWithLabel:menuLabelBack block:^(id sender)
                                         {
                                             [[CCDirector sharedDirector] popScene]; 
                                         }];
        CCLabelTTF* menuLabelQuit = [CCLabelTTF labelWithString:@"Quit" fontName:@"Nationalyze" fontSize:32];
        CCMenuItemLabel* menuItemQuit = [CCMenuItemLabel itemWithLabel:menuLabelQuit block:^(id sender)
                                         {
                                             [NSApp terminate:self];
                                         }];
        CCMenu* aMenu = [CCMenu menuWithItems:menuItemUDG, menuItemBack, menuItemQuit, nil];
		[aMenu alignItemsVertically];
        self.isMouseEnabled = YES;
        
        CCSprite* background = [CCSprite spriteWithFile:@"credits.png"];
        background.position = ccp(size.width / 2, size.height /2);
        [self addChild:background z:1];
        
        aMenu.position = ccp(900.0f, size.height / 2.0);
        [self addChild:aMenu z:10];
    }
    return self;
} 

- (BOOL) ccKeyUp:(NSEvent *)event
{
    [NSApp terminate:self];
    return YES;
}

@end
