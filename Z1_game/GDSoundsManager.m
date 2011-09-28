//
//  GDSoundsManager.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/20/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDSoundsManager.h"
#import "SimpleAudioEngine.h"

@interface GDSoundsManager()

@property (nonatomic, retain) NSMutableDictionary* sounds;
@property (nonatomic, retain) NSMutableDictionary* music;


@end

@implementation GDSoundsManager

@synthesize sounds = _sounds, music = _music;


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
        NSSound* temp = [self soundForName:@"BasicWeapon"];
        temp = [self soundForName:@"sfx-menu-click"];
        #pragma unused (temp)
        self.music = [NSMutableDictionary dictionary];
        [self.music setObject:@"sfx-level-start.mp3" forKey:@"levelIntro"];
        [self.music setObject:@"sfx-game-logo.mp3" forKey:@"mainMenu"];
        [self.music setObject:@"sfx-death-screen.mp3" forKey:@"gameOver"];
        [self.music setObject:@"sfx-credits-screen.mp3" forKey:@"credits"];
    }
    
    return self;
}

- (void)dealloc
{
    [_sounds release];
    [_music release];
    
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

- (void) playMusicForSceneNamed:(NSString*)name
{
    // map music to screens here
    NSString* filename = [self.music objectForKey:name];
    [self playMusicFromFilename:filename];
}

- (void) playMusicFromFilename:(NSString*)name
{
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:name];
}

@end
