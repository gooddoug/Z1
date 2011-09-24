//
//  GDMenuScreen.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDBaseEffectsScreen.h"
#import "cocos2d.h"
#import "Z1MessageOverlay.h"

@interface Z1MenuScreen : GDBaseEffectsScreen 
{
    Z1MessageOverlay* _messageOverlay;
}

@property (nonatomic, retain, readonly) Z1MessageOverlay* messageOverlay;

+(CCScene*) scene;

@end
