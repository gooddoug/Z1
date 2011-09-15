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
@property (nonatomic, retain) NSString* sprite;
@property float spriteSpeed;

@end

@implementation GDEnemySpriteEmitter

@synthesize howMany, howLong, time, frameAnimation = _frameAnimation, movementAnimation = _movementAnimation;
@synthesize spawned, sprite = _sprite, startInside = _startInside, spriteSpeed = _spriteSpeed;


- (void) dealloc
{
    [_frameAnimation release];
    [_movementAnimation release];
    
    [super dealloc];
}

- (id) initWithDictionary:(NSDictionary*)inDict
{
    if (( self = [super init] ))
    {
        self.howLong = [[inDict objectForKey:@"howLong"] intValue];
        self.howMany = [[inDict objectForKey:@"howMany"] intValue];
        self.movementAnimation = [[GDAnimationManager sharedAnimationManager] movementAnimationForKey:[inDict objectForKey:@"movementAnimation"]];
        self.spriteSpeed = [[inDict objectForKey:@"speed"] floatValue];
        if([inDict objectForKey:@"x"])
            self.position = ccp([[inDict objectForKey:@"x"] floatValue], [[inDict objectForKey:@"y"] floatValue]);
        else
            self.position = ccp(512, 383);
        
        NSNumber* rot;
        if ((rot = [inDict objectForKey:@"rotation"])) 
        {
            self.rotation = [rot floatValue];
        }
        NSNumber* startInside = [NSNumber numberWithBool:NO];
        if ((startInside = [inDict objectForKey:@"startInside"]))
        {
            self.startInside = [startInside boolValue];
        }
        self.sprite = [inDict objectForKey:@"sprite"];
    }
    return self;
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
    GDBasicSprite* enemySprite = [GDBasicSprite spriteWithFile:self.sprite];
    //enemySprite.position = self.position;
    enemySprite.rotation = self.rotation;
    enemySprite.animBlock = self.movementAnimation;
    enemySprite.scaleDirection = self.startInside ? -1 : 1;
    enemySprite.scale = self.startInside ? 0.01 : 1.0;
    enemySprite.speed = self.spriteSpeed;
    
    [(Z1GameScreen*)self.parent addEnemySprite:enemySprite];
}

- (void) movementAnimationForName:(NSString*)moveName
{
    
}

@end
