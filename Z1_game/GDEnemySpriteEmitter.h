//
//  GDEnemySpriteEmitter.h
//  MenuTest
//
//  Created by Doug Whitmore on 7/11/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GDEnemyBaseSprite.h"

@interface GDEnemySpriteEmitter : CCNode 
{
    
}

@property int howMany;
@property int howLong;
@property float time;

@property (copy, nonatomic) AnimBlock movementAnimation;
@property (retain, nonatomic) CCAnimation* frameAnimation;

- (void) spawnSprite;

@end
