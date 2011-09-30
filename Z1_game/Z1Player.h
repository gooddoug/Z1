//
//  Z1Player.h
//  Z1_game
//
//  Created by Doug Whitmore on 9/21/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Z1Player : NSObject
{
    int _score;
    int _lastLevel;
    
    CCSprite* _sprite;
}

@property int score;
@property int lastLevel;
@property (nonatomic, retain) CCSprite* sprite;

+ (Z1Player*) sharedPlayer;

- (void) resetPlayer;

@end
