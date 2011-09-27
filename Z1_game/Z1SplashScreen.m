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

@interface Z1SplashScreen ()
{
    BOOL movedOn;
}

@property BOOL movedOn;

@end

@implementation Z1SplashScreen

@synthesize movedOn;

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
	if(( self = [self initWithEffectNames:[NSArray array]] )) 
    {        
        self.isKeyboardEnabled = YES;
        self.isMouseEnabled = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
		CCSprite* background = [CCSprite spriteWithFile:@"title-screen-start.png"];
        background.position = ccp(size.width / 2.0, size.height /2);
        [self addChild:background z:0];
        
        CCSprite* endBackground = [CCSprite spriteWithFile:@"title-screen-end.png"];
        endBackground.position = ccp(size.width / 2.0, size.height /2);
        endBackground.opacity = 0.0;
        CCFadeIn* backgroundFadeAction = [CCFadeIn actionWithDuration:3.0];
        CCDelayTime* backgroundDelayAction = [CCDelayTime actionWithDuration:1.0];
        [endBackground runAction:[CCSequence actions:backgroundDelayAction, backgroundFadeAction, nil]];
        [self addChild:endBackground z:1];
        
        // add press any key label
        CCLabelTTF* pressKeyLabel = [CCLabelTTF labelWithString:@"Press any key" fontName:@"Helvetica" fontSize:48];
        pressKeyLabel.position = ccp(size.width / 2.0, 60.0);
        pressKeyLabel.opacity = 0.0;
        CCFadeIn* fadeAction = [CCFadeIn actionWithDuration:1.0];
        CCDelayTime* delayAction = [CCDelayTime actionWithDuration:4.5];
        [pressKeyLabel runAction:[CCSequence actions:delayAction, fadeAction, nil]];
        [self addChild:pressKeyLabel z:10];
        
        double delayInSeconds = 15.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (!self.movedOn)
                [self moveOn];
        });
	}
	return self;
}

- (BOOL) ccKeyUp:(NSEvent *)event
{
    [self moveOn];
    
    return YES;
}

- (BOOL) ccMouseUp:(NSEvent *)event
{
    [self moveOn];
}

- (void) moveOn
{
    self.movedOn = YES;
    [[GDSoundsManager sharedSoundsManager] playSoundForName:SCREEN_TRANSITION];
    CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                  scene:[Z1MenuScreen scene] 
                                                              withColor:ccWHITE];
    [[CCDirector sharedDirector] replaceScene:trans];
}

@end
