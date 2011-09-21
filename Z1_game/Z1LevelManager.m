//
//  Z1LevelManager.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/16/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1LevelManager.h"
#import "Z1GameScreen.h"
#import "Z1Player.h"

@implementation Z1LevelManager

static Z1LevelManager* sharedInstance = nil;

@synthesize levelList = _levelList, currentLevelIndex = _currentLevelIndex;

- (void) dealloc
{
    [_levelList release];
    
    [super dealloc];
}

+ (Z1LevelManager*) sharedLevelManager
{
    if (!sharedInstance)
    {
        sharedInstance = [[Z1LevelManager alloc] init];
    }
    return sharedInstance;
}

- (id)init
{
    return [self initWithLevels:[Z1LevelManager defaultLevels]];
}

- (id) initWithLevels:(NSArray*)inLevels
{
    if ((self = [super init]))
    {
        self.levelList = inLevels;
        self.currentLevelIndex = 0;
    }
    return self;
}

- (CCScene*) levelSceneAtIndex:(int)whichIndex
{
    if (whichIndex >= [self.levelList count])
    {
        NSLog(@"Trying to index past the level list, going back to 0");
        whichIndex = 0;
    }
    self.currentLevelIndex = whichIndex;
    NSString* whichLevel = [self.levelList objectAtIndex:self.currentLevelIndex];
    
    CCScene *scene = [CCScene node];
	
    // cheat this first time
	Z1GameScreen *layer = [[[Z1GameScreen alloc] initWithFile:whichLevel] autorelease];
	
	[scene addChild: layer];
	
	return scene;
}

- (void) finishedCurrentLevel
{
    [[CCDirector sharedDirector] replaceScene:[self nextGameScreen]];
}

- (CCScene*) nextGameScreen
{
    Z1Player* player = [Z1Player sharedPlayer];
    player.lastLevel = self.currentLevelIndex;
    
    self.currentLevelIndex++; 
    if (self.currentLevelIndex >= [self.levelList count])
    {
        self.currentLevelIndex = 0;
    }
    CCScene* nextScene = [self levelSceneAtIndex:self.currentLevelIndex];
    
    return nextScene;
}

+ (NSArray*) defaultLevels
{
    return [NSArray arrayWithObjects:@"simple_test", @"test_2", nil];
}

@end
