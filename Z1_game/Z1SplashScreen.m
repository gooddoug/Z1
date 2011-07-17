//
//  HelloWorldLayer.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright Good Doug 2011. All rights reserved.
//


// Import the interfaces
#import "Z1SplashScreen.h"

// HelloWorldLayer implementation
@implementation Z1SplashScreen

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	Z1SplashScreen *layer = [Z1SplashScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
	
		CCSprite* background = [CCSprite spriteWithFile:@"menu.png"];
        background.position = ccp(size.width / 2, size.height /2);
        [self addChild:background];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
