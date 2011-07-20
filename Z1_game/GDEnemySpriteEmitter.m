//
//  GDEnemySpriteEmitter.m
//  MenuTest
//
//  Created by Doug Whitmore on 7/11/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import "GDEnemySpriteEmitter.h"
#import "GDAnimationManager.h"
#import "Z1GameScreen.h"

@interface GDEnemySpriteEmitter()

@property (readonly) float intervalBetweenSpawns;
@property int spawned;

@end

@implementation GDEnemySpriteEmitter

@synthesize howMany, howLong, time, frameAnimation = _frameAnimation, movementAnimation = _movementAnimation;
@synthesize spawned;


- (void) dealloc
{
    [_frameAnimation release];
    [_movementAnimation release];
    
    [super dealloc];
}

- (id) init
{
    if ((self = [super init]))
    {
        self.time = 0.0;
        self.spawned = 0;
    }
    return self;
}

- (void) update:(ccTime)dt
{
    self.time = self.time + dt;
    if (self.time >= self.intervalBetweenSpawns && self.spawned < self.howMany)
    {
        [self spawnSprite];
        self.spawned++;
        self.time = self.time - self.intervalBetweenSpawns;
    }
}

- (float) intervalBetweenSpawns
{
    return (float)howLong/(float)howMany;
}

- (void) spawnSprite
{
    // create a new sprite and add it to the parent
    GDEnemyBaseSprite* enemySprite = [GDEnemyBaseSprite spriteWithFile:@"ship1.png"];
    enemySprite.position = self.position;
    enemySprite.rotation = self.rotation;
    enemySprite.animBlock = self.movementAnimation;
    enemySprite.scale = 0.25;
    enemySprite.speed = 300.0;
    
    [(Z1GameScreen*)self.parent addEnemySprite:enemySprite];
}

- (void) movementAnimtationForName:(NSString*)moveName
{
    
}

@end
