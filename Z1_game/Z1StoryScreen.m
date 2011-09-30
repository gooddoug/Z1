//
//  Z1StoryScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/29/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1StoryScreen.h"
#import "GDSoundsManager.h"


@implementation Z1StoryScreen

@synthesize movedOn;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	Z1StoryScreen *layer = [Z1StoryScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

- (void) dealloc
{
    
    [super dealloc];
}

-(id) init
{
	if(( self = [super init] )) 
    {        
        self.isKeyboardEnabled = YES;
        self.isMouseEnabled = YES;
        [[GDSoundsManager sharedSoundsManager] playSoundForName:@"junivision"];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
		CCSprite* background = [CCSprite spriteWithFile:@"main-menu-night.png"];
        background.position = ccp(size.width / 2.0, size.height /2);
        [self addChild:background z:0];
        
        CCNode* textNode = [CCNode node];
        CCSprite* textBackground = [CCSprite spriteWithFile:@"black_background.png"];
        textNode.contentSize = textBackground.contentSize;
        [textNode addChild:textBackground z:0];
        NSString* textPath = [[NSBundle mainBundle] pathForResource:@"saga" ofType:@"txt"];
        NSString* text = [NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:nil];
        CCLabelTTF* textLabel = [CCLabelTTF labelWithString:text fontName:@"Lucida Grande" fontSize:18];
        //textLabel.position = ccp(textNode.contentSize.width / 2, textNode.contentSize.height / 2);
        [textNode addChild:textLabel z:2];
        
        textNode.position = ccp(724, size.height / 2);
        
        [self addChild:textNode];
        
        // add press any key label
        CCLabelTTF* pressKeyLabel = [CCLabelTTF labelWithString:@"Press any key" fontName:@"Helvetica" fontSize:48];
        pressKeyLabel.position = ccp(size.width / 2.0, 60.0);
        pressKeyLabel.opacity = 0.0;
        CCFadeIn* fadeAction = [CCFadeIn actionWithDuration:1.0];
        CCDelayTime* delayAction = [CCDelayTime actionWithDuration:4.5];
        CCCallFunc* moveOnAction = [CCCallFunc actionWithTarget:self selector:@selector(moveOn:)];
        CCDelayTime* delay10Action = [CCDelayTime actionWithDuration:10];
        [pressKeyLabel runAction:[CCSequence actions:delayAction, fadeAction, delay10Action, nil]];
        [self addChild:pressKeyLabel z:10];
	}
	return self;
}

- (BOOL) ccKeyUp:(NSEvent *)event
{
    [self moveOn:self];
    
    return YES;
}

- (BOOL) ccMouseUp:(NSEvent *)event
{
    [self moveOn:self];
    return YES;
}

- (void) moveOn:(id)sender
{
    self.movedOn = YES;
    [[CCDirector sharedDirector] popScene];
    //[[GDSoundsManager sharedSoundsManager] playMusicForSceneNamed:@"mainMenu"];
}


@end
