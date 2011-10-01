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
#import "Z1GameOverOverlay.h"

@class GDInputManager;

@interface Z1GameScreen : CCLayerColor <GDGameScreenProtocol>
{
    GDInputManager* _inputManager;
    CCSprite* _playerSprite;
    NSMutableArray* _enemySprites;
    NSMutableSet* _playerShots;
    float _time;
    int _spawnerIndex;
    int _scriptIndex;
    BOOL _started;
    BOOL _gameOver;
    BOOL _wait;
    
    NSArray* _effects;
    NSDictionary* _levelDescription;
    CCSprite* _backgroundSprite;
    NSArray* _spawners;
    NSArray* _postScripts;
    NSMutableArray* _scriptNodes;
    Z1GameOverOverlay* _gameOverScreen;
    CCLabelAtlas* _scoreLabel;
}

@property (nonatomic, retain) NSDictionary* levelDescription;
@property BOOL wait;

+(CCScene*) scene;
+ (CCScene*) sceneWithDictionary:(NSDictionary*)levelDict;

- (id) initWithDictionary:(NSDictionary*)levelDict;

- (void) startLevel;
- (void) moveOn:(id) sender;

@end
