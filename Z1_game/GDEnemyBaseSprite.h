//
//  GDEnemyBase.h
//  MenuTest
//
//  Created by Doug Whitmore on 7/5/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//


/*
 This is a simple CCNode that contains a CCSprite. The primary use is that it has a heading
 and speed that it uses to calculate it's next position during an update event.
 
 You can call it  with a file, and it will set the sprite for you, or you can call it 
 and add a sprite later... which is useful if you want to set an animation
*/

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GDEnemyBaseSprite;

typedef void(^AnimBlock)(ccTime, GDEnemyBaseSprite*);

@interface GDEnemyBaseSprite : CCNode 
{
    float _speed;
    float _time;
    CCSprite* _sprite;
    id _animInfo;
    BOOL dead;
    AnimBlock animBlock;
}

@property (readonly) CGPoint heading;
@property float speed;
@property BOOL dead;
@property float time;
@property (nonatomic, retain) CCSprite* sprite;
@property (copy, nonatomic) AnimBlock animBlock;
@property (retain, nonatomic) id animInfo;

+ (GDEnemyBaseSprite*) spriteWithFile:(NSString*)inFilename;

- (id) initWithFile:(NSString*)inFilename;

@end
