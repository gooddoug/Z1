//
//  GDSoundsManager.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/20/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDSoundsManager.h"

@interface GDSoundsManager()

@property (nonatomic, retain) NSMutableDictionary* sounds;

@end

@implementation GDSoundsManager

@synthesize sounds = _sounds;


static GDSoundsManager* _soundsManager = nil;

+ (GDSoundsManager*) sharedSoundsManager
{
    if (!_soundsManager)
    {
        _soundsManager = [[GDSoundsManager alloc] init];
    }
    return _soundsManager;
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.sounds = [NSMutableDictionary dictionary];
        // preload any sounds here
        NSSound* temp = [self soundForName:@"screen_transition"];
        #pragma unused (temp)
    }
    
    return self;
}

- (void)dealloc
{
    [_sounds release];
    
    [super dealloc];
}

- (NSSound*) soundForName:(NSString*)inName
{
    NSSound* val = [self.sounds objectForKey:inName];
    if (!val)
    {
        // lazy loading
        val = [NSSound soundNamed:inName];
        if (!val)
        {
            NSLog(@"Unable to load sound named: %@", inName);
        }
        else
        {
            [self.sounds setObject:val forKey:inName];
        }
    }
    return val;
}

- (void) playSoundForName:(NSString*)inName
{
    NSSound* aSound = [self soundForName:inName];
    if (!aSound)
    {
        return;
    }
    if ([aSound isPlaying])
    {
        [aSound stop];
    }
    [aSound play];
}

@end
