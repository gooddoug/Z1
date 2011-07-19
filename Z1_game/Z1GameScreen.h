//
//  Z1GameScreen.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/19/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GDGameScreenProtocol.h"

@class GDInputManager;

@interface Z1GameScreen : CCLayer <GDGameScreenProtocol>
{
    
}

+(CCScene*) scene;

@end
