//
//  GDScrollingText.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/18/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDScrollingText.h"

@interface GDScrollingText()

@property (nonatomic, retain) CCLabelTTF* text;

@end

@implementation GDScrollingText

@synthesize background = _background, text = _text, scrollingSpeed;

- (void) dealloc
{
    [_background release];
    [_text release];
    
    [super dealloc];
}

- (id) initWithText:(NSString*)inText
{
    if (( self = [super init] ))
    {
        self.scrollingSpeed = 20.0;
        self.text = [CCLabelTTF labelWithString:inText fontName:@"Helvetica" fontSize:24];
        CGSize textSize = self.text.textureRect.size;
        
        self.text.position = ccp(0.0f, 0.0f);
        
        self.background = [CCSprite spriteWithFile:@"TextBackground.png"];
        //self.background.textureRect = self.text.textureRect;
        // scale the background
        if (textSize.width > self.background.textureRect.size.width)
        {
            float toScale = (textSize.width + 100) / self.background.textureRect.size.width;
            self.background.scaleX = toScale;
            self.background.scaleY = 1.5;
        }
        self.background.position = ccp(0.0f, 0.0f);
        
        [self addChild:self.text];
        
        [self scheduleUpdate];
    }
    return self;
}

- (id) initWithFile:(NSString*)inFilePath
{
    NSString* text = [NSString stringWithContentsOfFile:inFilePath encoding:NSUTF8StringEncoding error:nil];
    return [self initWithText:text];
}

- (void) setBackground:(CCSprite *)background
{
    if (_background == background)
    {
        return;
    }
    [background retain];
    [self removeChild:_background cleanup:YES];
    [_background release];
    _background = background;
    [self addChild:_background];
}

- (CCSprite*) background
{
    return _background;
}

- (void) update:(ccTime)dt
{
    CGPoint oldPoint = CGPointMake(self.text.position.x, self.text.position.y);
    self.text.position = ccp(oldPoint.x, oldPoint.y + (dt * self.scrollingSpeed));
}

@end
