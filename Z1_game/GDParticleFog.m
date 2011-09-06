//
//  GDParticleFog.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/4/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDParticleFog.h"
#import "GDUtilities.h"
#import "cocos2d.h"


#define DEFAULT_HOW_MANY 100

@implementation GDParticleFog

+ (GDParticleFog*) fog
{
    return [[[GDParticleFog alloc] init] autorelease];
}

- (id) init
{
    self = [self initWithTotalParticles:DEFAULT_HOW_MANY];
    
    return self;
}

- (id) initWithEffectDictionary:(NSDictionary*)inDict
{
    int howMany = [[inDict valueForKey:@"howMany"] intValue];
    if (!howMany)
    {
        howMany = DEFAULT_HOW_MANY;
    }
    self = [self initWithTotalParticles:howMany];
    
    // startColor
    NSDictionary* aStartColorDict = [inDict objectForKey:@"startColor"];
    if (aStartColorDict)
    {
        self.startColor = dictToColor(aStartColorDict);
    }
    
    // endColor
    NSDictionary* aEndColorDict = [inDict objectForKey:@"endColor"];
    if (aEndColorDict)
    {
        self.endColor = dictToColor(aEndColorDict);
    }
    
    // speed
    float aSpeed = [[inDict objectForKey:@"speed"] floatValue];
    if (aSpeed)
    {
        self.speed = aSpeed;
    }
    // startSize
    float aStartSize = [[inDict objectForKey:@"startSize"] floatValue];
    if (aStartSize)
    {
        self.startSize = aStartSize;
    }
    // endSize
    float aEndSize = [[inDict objectForKey:@"endSize"] floatValue];
    if (aEndSize)
    {
        self.endSize = aEndSize;
    }
    return self;
}


- (id) initWithTotalParticles:(NSUInteger)numberOfParticles
{
    if ((self = [super initWithTotalParticles:numberOfParticles]))
    {
        [self setTexture:[[CCTextureCache sharedTextureCache] addImage:@"smoke.png"]];
        [self setSpeed:70.0];
        [self setSpeedVar:20.0];
        ccColor4F aStartColor = {0.9, 0.9, 1.0, 0.0};
        ccColor4F aEndColor = {1.0, 0.9, 0.9, 0.4};
        [self setStartColor:aStartColor];
        [self setEndColor:aEndColor];
        self.angle = 90.0;
        self.angleVar = 360.0;
        self.life = 15.0;
        self.emissionRate = self.totalParticles/self.life;
        self.startSize = 150.0f;
		self.startSizeVar = 20.0f;
        self.endSize = 650.0f;
        self.endSizeVar = 50.0f;
        //spin
        self.startSpin = 0.0f;
        self.startSpinVar = 360.0;
        self.endSpin = 10.0;
        self.endSpinVar = 360.0;
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.position = ccp(size.width / 2, size.height / 2.0);
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
