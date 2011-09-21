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
        self.text = [CCLabelTTF labelWithString:inText fontName:@"Helvetica" fontSize:18];
        
        ClippingNode* clipNode = [ClippingNode node];
        
        clipNode.clippingRegion = CGRectMake(300, 300.0, 736, 350);
        self.text.position = ccp(0.0f, -400.0f);
        
        [self addChild:clipNode];
        
        [clipNode addChild:self.text];
        
        [self scheduleUpdate];
    }
    return self;
}

- (id) initWithFile:(NSString*)inFilePath
{
    NSString* text = [NSString stringWithContentsOfFile:inFilePath encoding:NSUTF8StringEncoding error:nil];
    return [self initWithText:text];
}

- (void) update:(ccTime)dt
{
    CGPoint oldPoint = CGPointMake(self.text.position.x, self.text.position.y);
    self.text.position = ccp(oldPoint.x, oldPoint.y + (dt * self.scrollingSpeed));
    
    // TODO: repeat after all text has scrolled
}

@end
