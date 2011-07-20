//
//  GDSoundsManager.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/20/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GDSoundsManager : NSObject 
{
    NSMutableDictionary* _sounds;
}

+ (GDSoundsManager*) sharedSoundsManager;

- (NSSound*) soundForName:(NSString*)inName;

- (void) playSoundForName:(NSString*)inName;

@end
