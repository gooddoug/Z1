//
//  GDMenuScreen.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Z1MessageOverlay.h"
#import "GDSpriteButton.h"

@interface Z1MenuScreen : CCLayer 
{
    Z1MessageOverlay* _messageOverlay;
    NSArray* _buttonArray;
    GDSpriteButton* _activeButton;
    long activeIndex;
    
    BOOL _doingSomething;
}

@property (nonatomic, retain) NSArray* buttonArray;
@property (nonatomic, retain) GDSpriteButton* activeButton;
@property long activeIndex;
@property (nonatomic, retain, readonly) Z1MessageOverlay* messageOverlay;
@property BOOL doingSomething;

+(CCScene*) scene;

@end
