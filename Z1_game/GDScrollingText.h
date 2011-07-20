//
//  GDScrollingText.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/18/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GDScrollingText : CCNode 
{
    CCSprite* _background;
    CCLabelTTF* _text;
    float scrollingSpeed;
}

@property (nonatomic, retain) CCSprite* background;
@property float scrollingSpeed;

- (id) initWithText:(NSString*)inText;
- (id) initWithFile:(NSString*)inFIlePath;

@end
