//
//  Z1LevelManager.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/16/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1LevelManager.h"
#import "Z1GameScreen.h"
#import "Z1PreLevelScreen.h"
#import "Z1EndScreen.h"
#import "Z1Player.h"

#define DEFAULT_LEVEL_LIST @"udg"

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
    return [self initWithLevelListFile:DEFAULT_LEVEL_LIST];
}

- (id) initWithLevelListFile:(NSString*)inFile
{
    NSArray* levels = nil;
    NSString* levelPath = [[NSBundle mainBundle] pathForResource:inFile ofType:@"level_list"];
    if (!levelPath)
    {
        NSLog(@"Was not able to get level path:%@", levelPath);
        return nil;
    }
    levels = [NSArray arrayWithContentsOfFile:levelPath];
    return [self initWithLevels:levels];
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
        return [Z1EndScreen scene];
    }
    self.currentLevelIndex = whichIndex;
    NSString* whichLevel = [self.levelList objectAtIndex:self.currentLevelIndex];
    
    CCScene *scene = [Z1PreLevelScreen sceneWithFile:whichLevel];
	
	return scene;
}

- (BOOL) moveToNextLevel
{
    CCScene* aScene = [self nextGameScreen];
    if (!aScene)
        return NO;
    [[CCDirector sharedDirector] replaceScene:aScene];
    return YES;
}

- (CCScene*) nextGameScreen
{
    Z1Player* player = [Z1Player sharedPlayer];
    self.currentLevelIndex++; 
    player.lastLevel = self.currentLevelIndex;
    
    CCScene* nextScene = [self levelSceneAtIndex:self.currentLevelIndex];
    
    return nextScene;
}

+ (NSArray*) defaultLevels
{
    return [NSArray arrayWithObjects:@"simple_test", @"test_2", nil];
}

@end
