//
//  Z1StoryScreen.h
//  Z1_game
//
//  Created by Doug Whitmore on 9/29/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Z1StoryScreen : CCLayer 
{    
    BOOL movedOn;
}

@property BOOL movedOn;

+(CCScene *) scene;

- (void) moveOn:(id)sender;

@end
