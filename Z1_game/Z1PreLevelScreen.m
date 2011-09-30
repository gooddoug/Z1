//
//  Z1PreLevelScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/27/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1PreLevelScreen.h"
#import "Z1GameScreen.h"
#import "GDSoundsManager.h"

@implementation Z1PreLevelScreen

@synthesize scripts = _scripts, scriptIndex = _scriptIndex, scriptNodes = _scriptNodes, skipButton = _skipButton, gameScene = _gameScene;

+(CCScene *) sceneWithFile:(NSString*)inName
{
	CCScene *aScene = [CCScene node];
	
	Z1PreLevelScreen *layer = [[[Z1PreLevelScreen alloc] initWithFile:inName] autorelease];
	
	[aScene addChild: layer];
	
	return aScene;
}

- (void) dealloc
{
    [_scriptNodes release];
    [_scripts release];
    
    [super dealloc];
}

- (id) initWithFile:(NSString*)inName
{
    if (( self = [super init] ))
    {
        self.isMouseEnabled = YES;
        self.isKeyboardEnabled = YES;
        
        [[GDSoundsManager sharedSoundsManager] playMusicForSceneNamed:@"levelIntro"];
        
        NSString* levelPath = [[NSBundle mainBundle] pathForResource:inName ofType:@"z1level"];
        if (!levelPath)
        {
            // find a folder next to the app named levels?
            NSLog(@"can't find the level");
        }
        NSDictionary* levelDescription = [NSDictionary dictionaryWithContentsOfFile:levelPath];
        // background music
        NSString* backgroundMusicName = [levelDescription objectForKey:@"backgroundMusic"];
        if(!backgroundMusicName)
            backgroundMusicName = @"Run_3_minute_edit.mp3";
        [[GDSoundsManager sharedSoundsManager] playMusicFromFilename:backgroundMusicName];
        
        self.gameScene = [Z1GameScreen sceneWithDictionary:levelDescription];
        self.scriptIndex = 0;
        self.scripts = [levelDescription objectForKey:@"preLevelScripts"];
        self.scriptNodes = [NSMutableArray array];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
		CCSprite* background = [CCSprite spriteWithFile:@"chapter-screen.png"];
        background.position = ccp(size.width / 2.0, size.height /2);
        [self addChild:background z:0];
        
        self.skipButton = [[[GDSpriteButton alloc] initWithTarget:self selector:@selector(done:) normalSprite:[CCSprite spriteWithFile:@"button-start.png"] selectedSprite:[CCSprite spriteWithFile:@"button-start-press.png"] hoverSprite:[CCSprite spriteWithFile:@"button-start-hover.png"]] autorelease];
        self.skipButton.position = ccp(size.width - ([self.skipButton contentSize].width + 10.0), 10.0);
        [self addChild:self.skipButton z:10];
        
        [self nextScript];
    }
    return self;
}

- (void) done:(id)sender
{
    [(Z1GameScreen*)[[self.gameScene children] objectAtIndex:0] startLevel];
    CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 scene:self.gameScene withColor:ccBLACK];
    [[CCDirector sharedDirector] replaceScene:trans];
}

- (BOOL) ccKeyDown:(NSEvent *)event
{
    unsigned char key = [event keyCode];
    if (key == 53)
    {
        [self.skipButton select];
        return YES;
    }
    return NO;
}


- (BOOL) ccKeyUp:(NSEvent *)event
{
    unsigned char key = [event keyCode];
    if (key == 53)
    {
        [self.skipButton activate];
        return YES;
    }
    [self nextScript];
    return YES;
}

- (BOOL) ccMouseDown:(NSEvent *)event
{
    CGPoint location = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
	CGPoint local = [self.skipButton convertToNodeSpace:location];
    CGRect rect = [self.skipButton rect];
    rect.origin = CGPointZero;
    if (CGRectContainsPoint(rect, local))
    {
        [self.skipButton select];
    }
    return YES;
}

- (BOOL) ccMouseUp:(NSEvent *)event
{
    CGPoint location = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
	CGPoint local = [self.skipButton convertToNodeSpace:location];
    CGRect rect = [self.skipButton rect];
    rect.origin = CGPointZero;
    if (CGRectContainsPoint(rect, local))
    {
        [self.skipButton activate];
        return YES;
    }
    [self nextScript];
    return YES;
}

- (void) nextScript
{
    if (self.scriptIndex >= [self.scripts count]) 
    {
        [self done:self];
        return;
    }
    NSDictionary* currentScript = [self.scripts objectAtIndex:self.scriptIndex];
    if (!currentScript)
    {
        [self done:self];
        return;
    }
    // create the node that will hold everything
    CCNode* chatNode = [CCNode node];
    CCSprite* chatBackground = [CCSprite spriteWithFile:@"dialog-boxes.png"];
    CCSprite* actorSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"head-%@.png", [currentScript objectForKey:@"actor"]]];
    NSString* text = [[[[NSAttributedString alloc] initWithData:[currentScript objectForKey:@"text"] options:nil documentAttributes:nil error:nil] autorelease] string];
    CCLabelTTF* textLabel = [CCLabelTTF labelWithString:text fontName:@"Lucida Grande" fontSize:18.0];
    float padding = 10.0;
    CGSize dialogSize = [chatBackground contentSize];
    CGSize actorSize = [actorSprite contentSize];
    CGSize nodeSize = CGSizeMake(dialogSize.width + actorSize.width + padding, dialogSize.height);
    [chatNode setContentSize:nodeSize];
    chatBackground.position = ccp((dialogSize.width / 2) + actorSize.width + padding, dialogSize.height / 2);
    actorSprite.position = ccp(actorSize.width / 2, dialogSize.height / 2);
    textLabel.position = ccp((dialogSize.width / 2) + actorSize.width + padding + padding, (dialogSize.height / 2) + padding);
    [chatNode addChild:chatBackground z:1];
    [chatNode addChild:actorSprite];
    [chatNode addChild:textLabel z:2];
    chatNode.position = ccp(50.0, 100.0);
    
    for (CCNode* aChatNode in self.scriptNodes) 
    {
        CCMoveBy* moveAction = [CCMoveBy actionWithDuration:0.5 position:ccp(0.0, dialogSize.height + padding)];
        [aChatNode runAction:moveAction];
        for (CCSprite* aSprite in aChatNode.children) 
        {
            float op = aSprite.opacity - 20;
            if (op < 0) 
                op = 0.0;
            aSprite.opacity = op;
        }
        
    }
    
    chatNode.visible = NO;
    CCToggleVisibility* visibility = [CCToggleVisibility action];
    CCDelayTime* delay = [CCDelayTime actionWithDuration:0.6];
    [chatNode runAction:[CCSequence actions:delay, visibility, nil]];
    
    [self.scriptNodes addObject:chatNode];
    [self addChild:chatNode z:5];    
    self.scriptIndex++;
}

@end
