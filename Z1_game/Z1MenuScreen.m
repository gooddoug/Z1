//
//  GDMenuScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1MenuScreen.h"
#import "Z1Player.h"
#import "Z1LevelManager.h"
#import "Z1PreLevelScreen.h"
#import "GDSoundsManager.h"

@implementation Z1MenuScreen

@synthesize buttonArray = _buttonArray, activeButton = _activeButton, activeIndex;

+ (void) initialize
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithBool:NO], @"finishedGame",
                                    nil];
    [defaults registerDefaults:defaultValues];
}

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	
	Z1MenuScreen *layer = [Z1MenuScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

- (void) dealloc
{
    [_messageOverlay release];
    [_buttonArray release];
    [_activeButton release];
    
    [super dealloc];
}

- (id) init
{
    if ((self = [super init]))
    {
        [self setIsMouseEnabled:YES];
        [self setIsKeyboardEnabled:YES];
        [[GDSoundsManager sharedSoundsManager] playMusicForSceneNamed:@"mainMenu"];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        // add background image
        NSString* backgroundImageString = @"main-menu.png";
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults boolForKey:@"finishedGame"])
            backgroundImageString = @"easter-egg.png";
        CCSprite* background = [CCSprite spriteWithFile:backgroundImageString];
        background.position = ccp(size.width / 2.0, size.height / 2.0);
        [self addChild:background z:0];
        
        // add buttons
        GDSpriteButton* startButton = [[[GDSpriteButton alloc] initWithTarget:self selector:@selector(start:) normalSprite:[CCSprite spriteWithFile:@"button-start.png"] selectedSprite:[CCSprite spriteWithFile:@"button-start-press.png"] hoverSprite:[CCSprite spriteWithFile:@"button-start-hover.png"]] autorelease];
        GDSpriteButton* restartButton = [[[GDSpriteButton alloc] initWithTarget:self selector:@selector(restart:) normalSprite:[CCSprite spriteWithFile:@"button-restart.png"] selectedSprite:[CCSprite spriteWithFile:@"button-restart-press.png"] hoverSprite:[CCSprite spriteWithFile:@"button-restart-hover.png"]] autorelease];
        GDSpriteButton* creditsButton = [[[GDSpriteButton alloc] initWithTarget:self selector:@selector(credits:) normalSprite:[CCSprite spriteWithFile:@"button-credits.png"] selectedSprite:[CCSprite spriteWithFile:@"button-credits-press.png"] hoverSprite:[CCSprite spriteWithFile:@"button-credits-hover.png"]] autorelease];
        GDSpriteButton* voteButton = [[[GDSpriteButton alloc] initWithTarget:self selector:@selector(vote:) normalSprite:[CCSprite spriteWithFile:@"button-vote.png"] selectedSprite:[CCSprite spriteWithFile:@"button-vote-press.png"] hoverSprite:[CCSprite spriteWithFile:@"button-vote-hover.png"]] autorelease];
        GDSpriteButton* sagaButton = [[[GDSpriteButton alloc] initWithTarget:self selector:@selector(saga:) normalSprite:[CCSprite spriteWithFile:@"button-saga.png"] selectedSprite:[CCSprite spriteWithFile:@"button-saga-press.png"] hoverSprite:[CCSprite spriteWithFile:@"button-saga-hover.png"]] autorelease];
        GDSpriteButton* quitButton = [[[GDSpriteButton alloc] initWithTarget:self selector:@selector(quit:) normalSprite:[CCSprite spriteWithFile:@"quit-button.png"] selectedSprite:[CCSprite spriteWithFile:@"quit-button-selected.png"] hoverSprite:nil] autorelease];
        
        startButton.position = ccp(685.0, 560.0);
        restartButton.position = ccp(715.0, 495.0);
        creditsButton.position = ccp(740.0, 430.0);
        voteButton.position = ccp(715.0, 365.0);
        sagaButton.position = ccp(685.0, 300.0);
        
        quitButton.position = ccp(960.0, 35.0);
        
        [self addChild:startButton];
        [self addChild:restartButton];
        [self addChild:creditsButton];
        [self addChild:voteButton];
        [self addChild:sagaButton];
        [self addChild:quitButton];
        
        self.buttonArray = [NSArray arrayWithObjects:startButton, restartButton, creditsButton, voteButton, sagaButton, quitButton, nil];
        self.activeIndex = -1;
    }
    
    return self;
}

- (void) start:(id)sender
{
    CCScene* levelScene = [[Z1LevelManager sharedLevelManager] levelSceneAtIndex:[Z1Player sharedPlayer].lastLevel];
    if (!levelScene)
    {
        [[Z1Player sharedPlayer] resetPlayer];
        levelScene = [[Z1LevelManager sharedLevelManager] levelSceneAtIndex:0];
    }
    CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 scene:levelScene withColor:ccWHITE];
    [[CCDirector sharedDirector] pushScene:trans];
}

- (void) restart:(id)sender
{
    // zero out the score and lastLevel
    [[Z1Player sharedPlayer] resetPlayer];
    CCTransitionScene* trans = [CCTransitionFade transitionWithDuration:1 
                                                                  scene:[[Z1LevelManager sharedLevelManager] levelSceneAtIndex:0]
                                                              withColor:ccWHITE];
    [[CCDirector sharedDirector] pushScene:trans];
}

// TODO: fix vote and credits and quit to do the right thing with overlay timing
- (void) credits:(id) sender
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
}

- (void) vote:(id) sender
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
        double delayInSeconds = 10.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.messageOverlay hide];
            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.udevgames.com/entries/210"]];
        });
        [[GDSoundsManager sharedSoundsManager] playSoundForName:SCREEN_TRANSITION];
    }
}

- (void) saga:(id)sender
{
    NSLog(@"Oh the tales we'll tell");
}

- (void) quit:(id)sender
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
#pragma mark Mouse

- (GDSpriteButton*) buttonForMouseEvent:(NSEvent*)inEvent
{
    CGPoint location = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:inEvent];
	for (GDSpriteButton* aButton in self.buttonArray) 
    {
        CGPoint local = [aButton convertToNodeSpace:location];
        CGRect rect = [aButton rect];
        rect.origin = CGPointZero;
        if (CGRectContainsPoint(rect, local))
        {
            return aButton;
        }
    }
    return nil;
}

- (BOOL) ccMouseDown:(NSEvent *)event
{
    // do whatever state stuff needs to be done now, before checking buttons...
    if (_messageOverlay && self.messageOverlay.showing)
    {
        return YES;
    }
    
    // did we click a button?
    GDSpriteButton* aButton = [self buttonForMouseEvent:event];
    if (aButton)
    {
        [aButton select];
        return YES;
    }
    
    return NO;
}

- (BOOL) ccMouseUp:(NSEvent *)event
{
    // do whatever state stuff needs to be done now, before checking buttons...
    if (_messageOverlay && self.messageOverlay.showing)
    {
        [self.messageOverlay hide];
        return YES;
    }
    
    // did we click a button?
    GDSpriteButton* aButton = [self buttonForMouseEvent:event];
    if (aButton)
    {
        [aButton activate];
        return YES;
    }
    
    return NO;
}

- (BOOL) ccMouseMoved:(NSEvent *)event
{
    // TODO: WHY WON"T THIS WORK! OH THE HUMANITY!
    CGPoint location = [(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
	for (GDSpriteButton* aButton in self.buttonArray) 
    {
        CGPoint local = [aButton convertToNodeSpace:location];
        CGRect rect = [aButton rect];
        rect.origin = CGPointZero;
        BOOL isOver = CGRectContainsPoint(rect, local);
        [aButton hover:isOver];
        if (isOver)
            self.activeButton = aButton;
    }
    
    return NO;
}

#pragma mark Keyboard

- (BOOL) ccKeyDown:(NSEvent *)event
{
    unsigned char key = [event keyCode];
    if (key == 36)
    {
        if (self.activeButton)
        {
            [self.activeButton select];
        }
        return YES;
    }
    return NO;
}

- (BOOL) ccKeyUp:(NSEvent *)event
{
    if (_messageOverlay && self.messageOverlay.showing)
    {
        [self.messageOverlay hide];
        return YES;
    }
    
    unsigned char key = [event keyCode];
    
    long newIndex = -1;
    if (key == 125)
    {
        // down arrow
        // select first or next
        NSLog(@"down");
        if (self.activeIndex == -1) 
        {
            newIndex = 0;
        } else
        {
            newIndex = self.activeIndex + 1;
        }
        if (newIndex >= [self.buttonArray count])
        {
            newIndex = [self.buttonArray count] - 1;
        }
        
    } else if (key == 126) 
    {
        // up arrow
        // select last or previous
        NSLog(@"up");
        if (self.activeIndex == -1) 
        {
            newIndex = [self.buttonArray count] - 1;
        }
        else
        {
            newIndex = self.activeIndex - 1;
        }
        if (newIndex < 0)
        {
            newIndex = 0;
        }
    } else if (key == 36)
    {
        // return key
        if (self.activeButton)
        {
            [self.activeButton activate];
        }
    }
    
    if (newIndex >= 0) 
    {
        if (self.activeIndex != newIndex)
        {
            if (self.activeIndex >= 0)
            {
                GDSpriteButton* oldButton = [self.buttonArray objectAtIndex:self.activeIndex];
                [oldButton hover:NO];
            }
            self.activeIndex = newIndex;
            GDSpriteButton* newButton = [self.buttonArray objectAtIndex:self.activeIndex];
            [newButton hover:YES];
            
            self.activeButton = newButton;
        }
    }
    
    return NO;
}

@end
