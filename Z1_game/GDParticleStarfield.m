//
//  GDParticleStarfield.m
//  MenuTest
//
//  Created by Doug Whitmore on 6/30/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDParticleStarfield.h"
#import "cocos2d.h"

@implementation GDParticleStarfield

+ (GDParticleStarfield*) starfield
{
    return [[[self alloc] init] autorelease];
}

- (id) init
{
    self = [self initWithTotalParticles:100];
    
    return self;
}

- (id) initWithTotalParticles:(NSUInteger)numberOfParticles
{
    if ((self = [super initWithTotalParticles:numberOfParticles]))
    {
        [self setTexture:[[CCTextureCache sharedTextureCache] addImage:@"stars.png"]];
        [self setSpeed:72.0];
        [self setSpeedVar:30.0];
        [self setStartSize:0.1];
        [self setEndSize:2.0];
        
        ccColor4F aStartColor = {0.82, 0.82, 1.0, 0.0};
        ccColor4F aEndColor = {1.0, 0.5, 0.5, 1.0};
        [self setStartColor:aStartColor];
        [self setEndColor:aEndColor];
        self.angle = 90.0;
        self.angleVar = 360.0;
        self.life = 4.0;
        self.lifeVar = 0.85;
        self.emissionRate = self.totalParticles/self.life;
        self.startSize = 4.0f;
		self.startSizeVar = 2.0f;
        self.endSize = 15.0f;
        self.endSizeVar = 4.0f;
        //spin
        self.startSpin = 0.0f;
        self.startSpinVar = 30.0;
        self.endSpin = 0.0;
        self.endSpinVar = 30.0;
        
        self.radialAccel = 100.0;
        self.radialAccelVar = 25.0;
    }
    return self;
}

@end
