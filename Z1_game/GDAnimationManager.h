//
//  GDAnimationManager.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/19/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GDUnboundSprite.h"


@interface GDAnimationManager : NSObject 
{
    NSDictionary* _animations;
}

@property (nonatomic, retain) NSDictionary* animations;

+ (GDAnimationManager*) sharedAnimationManager;


- (AnimBlock) movementAnimationForKey:(NSString*)key;

@end
