//
//  Z1Player.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/21/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1Player.h"

@implementation Z1Player

@synthesize score = _score;

static Z1Player* _staticPlayer = nil;

+ (Z1Player*) sharedPlayer
{
    if (!_staticPlayer)
    {
        _staticPlayer = [[Z1Player alloc] init];
    }
    return _staticPlayer;
}

+ (void) initialize
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:0], @"lastLevel",
                                   [NSNumber numberWithInt:0], @"score",
                                   nil];
    [defaults registerDefaults:defaultValues];
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        self.score = (int)[defaults integerForKey:@"score"];
        self.lastLevel = (int)[defaults integerForKey:@"lastLevel"];
    }
    
    return self;
}

- (void) setLastLevel:(int)lastLevel
{
    _lastLevel = lastLevel;
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:lastLevel forKey:@"lastLevel"];
    // also save the last score
    [defaults setInteger:self.score forKey:@"score"];
}

- (int) lastLevel
{
    return _lastLevel;
}

- (void) resetPlayer
{
    NSLog(@"resetting player");
    self.score = 0;
    self.lastLevel = 0;
}

@end
