//
//  GDSoundsManager.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/20/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// some constants:
#define SCREEN_TRANSITION @"sfx_menu_click"


@interface GDSoundsManager : NSObject 
{
    NSMutableDictionary* _sounds;
    NSMutableDictionary* _music;
}

+ (GDSoundsManager*) sharedSoundsManager;

- (NSSound*) soundForName:(NSString*)inName;
- (void) playSoundForName:(NSString*)inName;

- (void) playMusicForSceneNamed:(NSString*)name;
- (void) playMusicFromFilename:(NSString*)name;

@end
