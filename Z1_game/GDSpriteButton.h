//
//  GDSpriteButton.h
//  Z1MenuTest
//
//  Created by Doug Whitmore on 9/26/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GDSpriteButton : CCNode 
{
    id _target;
    NSInvocation* invocation;
    
    BOOL _isActive; 
    BOOL _isSelected;
    
    CCSprite* _normalSprite;
    CCSprite* _selectedSprite;
    CCSprite* _hoverSprite;
}

@property (nonatomic, retain) id target;
@property BOOL active;
@property BOOL selected;
@property (nonatomic, retain)CCSprite* normalSprite;
@property (nonatomic, retain)CCSprite* selectedSprite;
@property (nonatomic, retain)CCSprite* hoverSprite;


- (id) initWithTarget:(id)target selector:(SEL)sel normalSprite:(CCSprite*)normal selectedSprite:(CCSprite*)selected hoverSprite:(CCSprite*)hover;


- (void) hover:(BOOL)isOver;
- (void) select;
- (void) activate;

- (CGRect) rect;

@end
