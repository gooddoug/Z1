//
//  Z1MessageOverlay.h
//  Z1_game
//
//  Created by Doug Whitmore on 9/23/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Z1MessageOverlay : CCLayer 
{
    NSString* _text;
    CCSprite* _monitor;
    CCSprite* _textSprite;
    BOOL _showing;
    BOOL _animating;
}

@property (nonatomic, retain) NSString* text;
@property BOOL showing;
@property BOOL animating;

- (id) initWithText:(NSString*)inMessage;

- (void) show;
- (void) hide;
- (void) toggle;

@end
