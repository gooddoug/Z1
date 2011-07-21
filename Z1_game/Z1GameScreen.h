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
    GDInputManager* _inputManager;
    CCSprite* _playerSprite;
    NSMutableArray* _enemySprites;
    NSMutableSet* _playerShots;
    float _time;
    int _spawnerIndex;
    
    NSArray* _effects;
    NSDictionary* _levelDescription;
    CCSprite* _backgroundSprite;
    NSArray* _spawners;
}

+(CCScene*) scene;

@end
