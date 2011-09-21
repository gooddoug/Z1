//
//  HelloWorldLayer.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright Good Doug 2011. All rights reserved.
//


#import "Z1SplashScreen.h"
#import "Z1MenuScreen.h"
#import "GDSoundsManager.h"

@implementation Z1SplashScreen


+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	Z1SplashScreen *layer = [Z1SplashScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

- (void) dealloc
{
    
    [super dealloc];
}

-(id) init
{
	if(( self = [self initWithEffectNames:[NSArray arrayWithObjects:@"GDParticleStarfield", nil]] )) 
    {        
        self.isKeyboardEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
		CCSprite* background = [CCSprite spriteWithFile:@"title-screen-start.png"];
        background.position = ccp(size.width / 2.0, size.height /2);
        [self addChild:background z:0];
        
        CCSprite* endBackground = [CCSprite spriteWithFile:@"title-screen-end.png"];
        endBackground.position = ccp(size.width / 2.0, size.height /2);
        endBackground.opacity = 0.0;
        CCFadeIn* backgroundFadeAction = [CCFadeIn actionWithDuration:1.0];
        CCDelayTime* backgroundDelayAction = [CCDelayTime actionWithDuration:1.0];
        [endBackground runAction:[CCSequence actions:backgroundDelayAction, backgroundFadeAction, nil]];
        [self addChild:endBackground z:1];
        
        // add press any key label
        CCLabelTTF* pressKeyLabel = [CCLabelTTF labelWithString:@"Press any key" fontName:@"Helvetica" fontSize:48];
        pressKeyLabel.position = ccp(size.width / 2.0, 100.0);
        pressKeyLabel.opacity = 0.0;
        CCFadeIn* fadeAction = [CCFadeIn actionWithDuration:1.0];
        CCDelayTime* delayAction = [CCDelayTime actionWithDuration:3.0];
        [pressKeyLabel runAction:[CCSequence actions:delayAction, fadeAction, nil]];
        [self addChild:pressKeyLabel z:10];
	}
	return self;
}

- (BOOL) ccKeyUp:(NSEvent *)event
{
    [[GDSoundsManager sharedSoundsManager] playSoundForName:SCREEN_TRANSITION];
    [[CCDirector sharedDirector] replaceScene:[Z1MenuScreen scene]];
    
    return YES;
}

@end
