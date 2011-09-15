//
//  GDEnemySpriteEmitter.h
//  MenuTest
//
//  Created by Doug Whitmore on 7/11/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GDUnboundSprite.h"

@interface GDEnemySpriteEmitter : CCNode 
{
    int howMany;
    int howLong;
    float time;
    float _spriteSpeed;
    int spawned;
    BOOL _startInside;
    NSString* _sprite;
    
    AnimBlock _movementAnimation;
    CCAnimation* _frameAnimation;
}

@property int howMany;
@property int howLong;
@property float time;
@property BOOL startInside;

@property (copy, nonatomic) AnimBlock movementAnimation;
@property (retain, nonatomic) CCAnimation* frameAnimation;


- (id) initWithDictionary:(NSDictionary*)inDict;

- (void) spawnSprite;

@end
