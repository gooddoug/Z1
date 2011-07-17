//
//  AppDelegate.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright Good Doug 2011. All rights reserved.
//

#import "cocos2d.h"

@interface Z1_gameAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	MacGLView	*glView_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet MacGLView	*glView;

- (IBAction)toggleFullScreen:(id)sender;

@end
