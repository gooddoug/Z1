//
//  GDInputManager.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/3/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDInputManager.h"

@interface GDInputManager()

@property unsigned char fireKey;
@property unsigned char rightKey;
@property unsigned char leftKey;
@property unsigned char pauseKey;

@end

#define FIRE_KEY @"input_fireKey"
#define LEFT_KEY @"input_leftKey"
#define RIGHT_KEY @"input_rightKey"
#define PAUSE_KEY @"input_pauseKey"

@implementation GDInputManager

@synthesize right, left, pause, fire = _fire;

@synthesize fireKey, rightKey, leftKey, pauseKey;

+ (void) initialize
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* controlDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:49], FIRE_KEY,  
                                    [NSNumber numberWithInt:123], LEFT_KEY, 
                                    [NSNumber numberWithInt:124], RIGHT_KEY, 
                                    [NSNumber numberWithInt:53], PAUSE_KEY, 
                                    nil];
    [defaults registerDefaults:controlDefaults];
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        
        self.fireKey = [defaults integerForKey:FIRE_KEY];
        self.leftKey = [defaults integerForKey:LEFT_KEY];
        self.rightKey = [defaults integerForKey:RIGHT_KEY];
        self.pauseKey = [defaults integerForKey:PAUSE_KEY];
    }
    
    return self;
}

- (BOOL) handleKeyDown:(NSEvent *)event
{
    // NSLog(@"key down event: %@", [event description]);
    
    // swallow repeats
    if ([event isARepeat])
        return FALSE;
    
    unsigned char key = [event keyCode];
    
    if(key == self.fireKey)
    {
        // space
        //NSLog(@"BANG!");
        self.fire = TRUE;
        return TRUE;
    }
    if(key == self.leftKey)
    {
        self.left = TRUE;
        return TRUE;
    }
    if(key == self.rightKey)
    {
        // right arrow
        self.right = TRUE;
        return TRUE;
    }
    if(key == self.pauseKey)
    {
        self.pause = TRUE;
        return TRUE;
    }
     
    return FALSE;
}

- (BOOL) handleKeyUp:(NSEvent *)event
{
    unsigned char key = [event keyCode];
    
    if(key == self.fireKey)
    {
        // space
        self.fire = FALSE;
        return TRUE;
    }
    if(key == self.leftKey)
    {
        self.left = FALSE;
        return TRUE;
    }
    if(key == self.rightKey)
    {
        // right arrow
        self.right = FALSE;
        return TRUE;
    }
    
    return FALSE;
}

// have to handle the fire button differently
- (BOOL) fire
{
    // return yes only the first time it's asked
    if (_fire)
    {
        _fire = NO;
        return YES;
    }
    return NO;
}

- (void) setFire:(BOOL)fire
{
    _fire = fire;
}

- (void) synchDefaults
{
    // to update the defaults if they've changed the keys
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.fireKey forKey:FIRE_KEY];
    [defaults setInteger:self.leftKey forKey:LEFT_KEY];
    [defaults setInteger:self.rightKey forKey:RIGHT_KEY];
    [defaults setInteger:self.leftKey forKey:LEFT_KEY];
}

- (void)dealloc
{
    [super dealloc];
}

@end
