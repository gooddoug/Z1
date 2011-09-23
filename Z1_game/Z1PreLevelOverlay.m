//
//  Z1PreLevelOverlay.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/15/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1PreLevelOverlay.h"
#import "Z1GameScreen.h"


@implementation Z1PreLevelOverlay

@synthesize scripts = _scripts, scriptIndex = _scriptIndex, currentActor = _currentActor, currentText = _currentText;

- (id) initWithScripts:(NSArray *)scripts
{
    if ((self = [super init]))
    {
        self.isKeyboardEnabled = YES;
        self.scripts = scripts;
        self.scriptIndex = 0;
        [self scheduleUpdate];
        
        // set up the text area
        CCSprite* background = [CCSprite spriteWithFile:@"TextBackground.png"];
        background.scale = 1.5;
        CGSize size = [[CCDirector sharedDirector] winSize];
        background.position = ccp( size.width / 2 , size.height / 2);
        
        [self addChild:background];
        
        // set up the skip button
        CCLabelTTF* menuLabelBack = [CCLabelTTF labelWithString:@"Skip" fontName:@"Helvetica" fontSize:24];
        CCMenuItemLabel* menuItemBack = [CCMenuItemLabel itemWithLabel:menuLabelBack block:^(id sender)
                                         {
                                             [self done]; 
                                         }];
        CCMenu* aMenu = [CCMenu menuWithItems:menuItemBack, nil];
		[aMenu alignItemsVertically];
        self.isMouseEnabled = YES;
        
        aMenu.position = ccp(900.0f, 100.0f);
        [self addChild:aMenu z:10];
        [self nextScript];
    }
    return self;
}

- (void) dealloc
{
    [_scripts release];
    [super dealloc];
}

- (void) done
{
    [(Z1GameScreen*)self.parent prelevelScriptsFinished];
}

- (void) update:(ccTime)dt
{
    
}

- (BOOL) ccKeyUp:(NSEvent *)event
{
    [self nextScript];
    return YES;
}

- (void) nextScript
{
    if (self.scriptIndex >= [self.scripts count]) 
    {
        [self done];
        return;
    }
    NSDictionary* currentScript = [self.scripts objectAtIndex:self.scriptIndex];
    if (!currentScript)
    {
        [self done];
        return;
    }
    
    if (self.currentActor)
        [self removeChild:self.currentActor cleanup:YES];
    self.currentActor = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@-head.png", [currentScript objectForKey:@"actor"]]];
    self.currentActor.position = ccp(250.0, 500.0);
    [self addChild:self.currentActor];
    
    if (self.currentText)
        [self removeChild:self.currentText cleanup:YES];
    
    NSString* text = [[[NSAttributedString alloc] initWithData:[currentScript objectForKey:@"text"] options:nil documentAttributes:nil error:nil] string];
    self.currentText = [CCLabelTTF labelWithString:text fontName:@"Helvetica" fontSize:24];
    CGSize size = [[CCDirector sharedDirector] winSize];

    self.currentText.position = ccp(size.width / 2, 200.0);
    [self addChild:self.currentText];
    
    self.scriptIndex++;
}

@end
