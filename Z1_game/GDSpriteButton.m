//
//  GDSpriteButton.m
//  Z1MenuTest
//
//  Created by Doug Whitmore on 9/26/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDSpriteButton.h"


@implementation GDSpriteButton

@synthesize target = _target, active = _isActive, selected = _isSelected;

- (void) dealloc
{
    [_target release];
    [_normalSprite release];
    [_selectedSprite release];
    [_hoverSprite release];
    
    [invocation release];
    
    [super dealloc];
}

- (id) initWithTarget:(id)target selector:(SEL)sel normalSprite:(CCSprite*)normal selectedSprite:(CCSprite*)clicked hoverSprite:(CCSprite*)hover
{
    if (( self = [super init] ))
    {
        NSMethodSignature* sig = nil;
        self.target = target;
        if (target && sel)
        {
            sig = [target methodSignatureForSelector:sel];
            invocation = [NSInvocation invocationWithMethodSignature:sig];
            [invocation setTarget:self.target];
            [invocation setSelector:sel];
            [invocation setArgument:&self atIndex:2];
            
            [invocation retain];
        }
        self.normalSprite = normal;
        self.selectedSprite = clicked;
        self.hoverSprite = hover;
    }
    return self;
}

- (void) hover:(BOOL)isOver
{
    if (self.active == isOver)
        return;
    self.active = isOver;
    if (self.hoverSprite)
    {
        // swap state of normal and hover
        [self.normalSprite setVisible:!isOver];
        [self.hoverSprite setVisible:isOver];
    }
}

- (void) select
{
    self.selected = YES;
    if (self.selectedSprite)
    {
        [self.normalSprite setVisible:NO];
        [self.selectedSprite setVisible:YES];
        [self.hoverSprite setVisible:NO];
    }
}

- (void) activate
{
    self.selected = NO;
    if (self.selectedSprite)
    {
        [self.normalSprite setVisible:YES];
        [self.selectedSprite setVisible:NO];
    }
    [invocation invoke];
}

- (CGRect) rect
{
	return CGRectMake( position_.x - contentSize_.width*anchorPoint_.x,
					  position_.y - contentSize_.height*anchorPoint_.y,
					  contentSize_.width, contentSize_.height);	
}

#pragma mark accessors

- (CCSprite*) normalSprite
{
    return [[_normalSprite retain] autorelease];
}

- (void) setNormalSprite:(CCSprite *)normalSprite
{
    if (normalSprite != _normalSprite)
    {
        normalSprite.visible = YES;
        normalSprite.anchorPoint = ccp(0.0, 0.0);
        [self removeChild:_normalSprite cleanup:YES];
        [self addChild:normalSprite];
        [self setContentSize:[normalSprite contentSize]];
        
        _normalSprite = normalSprite;
    }
}

- (CCSprite*) selectedSprite
{
    return [[_selectedSprite retain] autorelease];
}

- (void) setSelectedSprite:(CCSprite *)selectedSprite
{
    if (selectedSprite != _selectedSprite)
    {
        selectedSprite.visible = NO;
        selectedSprite.anchorPoint = ccp(0.0, 0.0);
        
        [self removeChild:_selectedSprite cleanup:YES];
        [self addChild:selectedSprite];
        
        _selectedSprite = selectedSprite;
    }
}

- (CCSprite*) hoverSprite
{
    return [[_hoverSprite retain] autorelease];
}

- (void) setHoverSprite:(CCSprite *)hoverSprite
{
    if (hoverSprite != _hoverSprite)
    {
        hoverSprite.visible = NO;
        hoverSprite.anchorPoint = ccp(0.0, 0.0);
        
        [self removeChild:_hoverSprite cleanup:YES];
        [self addChild:hoverSprite];
        
        _hoverSprite = hoverSprite;
    }
}
@end
