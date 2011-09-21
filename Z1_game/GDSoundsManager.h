//
//  GDSoundsManager.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/20/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// some constants:
#define SCREEN_TRANSITION @"ui_click_ok"


@interface GDSoundsManager : NSObject 
{
    NSMutableDictionary* _sounds;
}

+ (GDSoundsManager*) sharedSoundsManager;

- (NSSound*) soundForName:(NSString*)inName;

- (void) playSoundForName:(NSString*)inName;

@end
