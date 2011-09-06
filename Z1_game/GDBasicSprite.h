//
//  GDBasicSprite.h
//  Z1_game
//
//  Created by Doug Whitmore on 9/6/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GDBasicSprite;

typedef void(^AnimBlock)(ccTime, GDBasicSprite*);

@interface GDBasicSprite : CCNode 
{
    float _speed;
    float _time;
    CCSprite* _sprite;
    id _animInfo;
    BOOL dead;
    int _currentFrame;
    CGPoint _heading;
    AnimBlock animBlock;
}

@property (readwrite) CGPoint heading;
@property float speed;
@property BOOL dead;
@property float time;
@property int currentFrame;
@property (nonatomic, retain) CCSprite* sprite;
@property (copy, nonatomic) AnimBlock animBlock;
@property (retain, nonatomic) id animInfo;

+ (GDBasicSprite*) spriteWithFile:(NSString*)inFilename;
+ (GDBasicSprite*) spriteWithDict:(NSDictionary*)inDict;

- (id) initWithFile:(NSString*)inFilename;

- (void) update:(ccTime)dt;

@end
