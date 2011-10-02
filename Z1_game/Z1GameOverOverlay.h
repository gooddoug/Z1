//
//  Z1GameOverOverlay.h
//  Z1_game
//
//  Created by Doug Whitmore on 9/22/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Z1GameOverOverlay : CCLayer 
{
    BOOL showing;
    BOOL waiting;
}

@property BOOL showing;
@property BOOL waiting;

- (id) initAndFinsihed:(BOOL)finished;

@end
