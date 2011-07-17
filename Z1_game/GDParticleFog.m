//
//  GDParticleFog.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/4/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDParticleFog.h"
#import "cocos2d.h"


@implementation GDParticleFog

+ (GDParticleFog*) fog
{
    return [[[GDParticleFog alloc] init] autorelease];
}

- (id) init
{
    self = [self initWithTotalParticles:50];
    
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
        self.life = 9.0;
        self.emissionRate = self.totalParticles/self.life;
        self.startSize = 150.0f;
		self.startSizeVar = 20.0f;
        self.endSize = 450.0f;
        self.endSizeVar = 30.0f;
        //spin
        self.startSpin = 0.0f;
        self.startSpinVar = 360.0;
        self.endSpin = 10.0;
        self.endSpinVar = 360.0;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
