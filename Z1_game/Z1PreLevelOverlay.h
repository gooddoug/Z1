//
//  Z1PreLevelOverlay.h
//  Z1_game
//
//  Created by Doug Whitmore on 9/15/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Z1PreLevelOverlay : CCLayer 
{
    NSArray* _scripts;
    int _scriptIndex;
    CCSprite* _currentActor;
    CCSprite* _currentText;
}

@property (nonatomic, retain) NSArray* scripts;
@property int scriptIndex;
@property (nonatomic, retain) CCSprite* currentActor;
@property (nonatomic, retain) CCSprite* currentText;

- (id) initWithScripts:(NSArray*)scripts;

- (void) done;
- (void) nextScript;

@end
