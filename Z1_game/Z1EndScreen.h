//
//  Z1EndScreen.h
//  Z1_game
//
//  Created by Doug Whitmore on 9/27/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GDBaseEffectsScreen.h"

@interface Z1EndScreen : GDBaseEffectsScreen
{
    BOOL movedOn;
}

+(CCScene *) scene;

- (void) moveOn:(id)sender;

@end
