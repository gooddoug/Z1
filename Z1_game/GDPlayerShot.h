//
//  GDPlayerShot.h
//  MenuTest
//
//  Created by Doug Whitmore on 7/9/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GDPlayerShot : CCSprite 
{
    
}

@property float timeAlive;
@property BOOL hitSomething;
@property CGPoint decay;

+ (GDPlayerShot*) shotAtRotation:(float)inRotation anchorPoint:(CGPoint)inPoint;

@end
