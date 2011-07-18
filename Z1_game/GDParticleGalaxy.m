//
//  GDParticleGalaxy.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDParticleGalaxy.h"


@implementation GDParticleGalaxy

@synthesize particleEmitter = _particleEmitter, center = _center, rotationalSpeed;

+ (GDParticleGalaxy*) galaxy
{
    return [[[self alloc] init] autorelease];
}

- (void) dealloc
{
    [_particleEmitter release];
    
    [super dealloc];
}

- (id) init
{
    return [self initWithTotalParticles:600];
}

- (id) initWithTotalParticles:(NSUInteger)numberOfParticles
{
    if (( self = [super init] ))
    {
        // Particle Emitter...
        self.particleEmitter = [[[CCParticleGalaxy alloc] initWithTotalParticles:numberOfParticles] autorelease];
        // update parameters here...
        // Gravity Mode: speed of particles
		self.particleEmitter.speed = 20;
		self.particleEmitter.speedVar = 5;
        
		// Gravity Mode: radial
		self.particleEmitter.radialAccel = -10;
		self.particleEmitter.radialAccelVar = 2;
		
		// Gravity Mode: tagential
		self.particleEmitter.tangentialAccel = 10;
		self.particleEmitter.tangentialAccelVar = 2;
		
		// angle
		self.particleEmitter.angle = 90;
		self.particleEmitter.angleVar = 360;
		
        // life of particles
		self.particleEmitter.life = 18;
		self.particleEmitter.lifeVar = 1;
		
		// size, in pixels
		self.particleEmitter.startSize = 10.0f;
		self.particleEmitter.startSizeVar = 5.0f;
		self.particleEmitter.endSize = kCCParticleStartSizeEqualToEndSize;
		
		// emits per second
		self.particleEmitter.emissionRate = self.particleEmitter.totalParticles/self.particleEmitter.life;
		
		// color of particles
        ccColor4F aStartColor = {0.12f, 0.25f, 0.76f, 1.0f};
        ccColor4F aEndColor = {0.0f, 0.0f, 0.0f, 0.0f};
        ccColor4F aStartColorVar = {1.0f, 1.0f, 0.0f, 0.0f};
        [self.particleEmitter setStartColor:aStartColor];
        [self.particleEmitter setEndColor:aEndColor];
        [self.particleEmitter setStartColorVar:aStartColorVar];
        
        self.position = ccp(0.0f, 0.0f);
        
        [self addChild:self.particleEmitter z:1];
        
        // big white sprite
        self.center = [CCSprite spriteWithFile:@"galaxy.png"];
        self.center.scale = 12.0;
        CGSize size = [[CCDirector sharedDirector] winSize];        
        [self.center setPosition:ccp(size.width / 2, size.height / 2.0)];
        
        self.rotationalSpeed = 3.0f;
        
        [self addChild:self.center z:3];
        
        [self scheduleUpdate];
    }
    
    return self;
}

- (void) update:(ccTime)dt
{
    float currentRotation = self.center.rotation;
    float rotDelta = self.rotationalSpeed * dt;
    self.center.rotation = currentRotation + rotDelta;
}

@end
