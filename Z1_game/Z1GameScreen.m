//
//  Z1GameScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/19/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "Z1GameScreen.h"
#import "GDInputManager.h"
#import "GDPlayerShot.h"
#import "GDEnemySpriteEmitter.h"
#import "GDSoundsManager.h"

@interface Z1GameScreen ()

@property (nonatomic, retain) NSDictionary* levelDescription;
@property (nonatomic, retain) CCSprite* backgroundSprite;

- (void) sweep;
- (void) resolveFire;

@end

@implementation Z1GameScreen

@synthesize inputManager = _inputManager, playerSprite = _playerSprite, enemySprites = _enemySprites;
@synthesize playerShots = _playerShots, effects = _effects;

@synthesize levelDescription = _levelDescription, backgroundSprite = _backgroundSprite;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	
	Z1GameScreen *layer = [Z1GameScreen node];
	
	[scene addChild: layer];
	
	return scene;
}

- (void) dealloc
{
    [_inputManager release];
    [_playerShots release];
    [_enemySprites release];
    [_playerShots release];
    [_effects release];
    [_levelDescription release];
    [_backgroundSprite release];
    
    [super dealloc];
}

- (id) init
{
    if (( self = [super init] ))
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        self.isKeyboardEnabled = YES;
        self.inputManager = [[[GDInputManager alloc] init] autorelease];
        [self scheduleUpdate];
        self.enemySprites = [NSMutableArray array];
        self.playerShots = [NSMutableSet set];
                
        self.playerSprite = [CCSprite spriteWithFile:@"ship1.png"];
        self.playerSprite.scale = 0.25;
        
        self.playerSprite.anchorPoint = ccp( 0.65 , 10.0 );
        self.playerSprite.position = ccp( size.width /2 , size.height/2 );
        
        [self addChild:self.playerSprite z:20];
        [[GDSoundsManager sharedSoundsManager] playSoundForName:@"level_start"];
    }
    return self;
}

- (BOOL) ccKeyDown:(NSEvent *)event
{
    return [self.inputManager handleKeyDown:event];
}


- (BOOL) ccKeyUp:(NSEvent *)event
{
    return [self.inputManager handleKeyUp:event];
}

- (void) update:(ccTime)dt
{
    if (self.inputManager.pause)
    {
        [[CCDirector sharedDirector] popScene];
    }
    
    BOOL moved = FALSE;
    // quick and dirty test...
    if (self.inputManager.left)
    {
        /*CGPoint currPos = self.playerSprite.position;
         CGPoint newPos = ccp(currPos.x + (dt * 100), currPos.y);
         self.playerSprite.position = newPos;*/
        float rot = self.playerSprite.rotation + (200 * dt);
        if (rot < 0)
        {
            rot = 360.0 + rot;
        }
        if (rot > 360)
        {
            rot = rot - 360.0;
        }
        self.playerSprite.rotation = rot;
        moved = TRUE;
    }
    if (self.inputManager.right)
    {
        /*CGPoint currPos = self.playerSprite.position;
         CGPoint newPos = ccp(currPos.x - (dt * 100), currPos.y);
         self.playerSprite.position = newPos;*/
        float rot = self.playerSprite.rotation - (200 * dt);
        if (rot < 0)
        {
            rot = 360.0 + rot;
        }
        if (rot > 360)
        {
            rot = rot - 360.0;
        }
        self.playerSprite.rotation = rot;
        moved = TRUE;
    }
    if (moved)
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        CGPoint shift = CGPointApplyAffineTransform(CGPointMake(0.0, 10.0), CGAffineTransformMakeRotation((-self.playerSprite.rotation) * (3.141596 / 180.0)));
        self.backgroundSprite.position = ccp( (size.width /2) + shift.x , (size.height/2) + shift.y);
    }
    
    // Fire!
    if (self.inputManager.fire)
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        GDPlayerShot* aShot = [GDPlayerShot shotAtRotation:self.playerSprite.rotation anchorPoint:ccp(0.5, 16.0)];
        aShot.position = ccp( size.width /2 , size.height/2 );
        
        [self addChild:aShot z:10];
        [self.playerShots addObject:aShot];
        [aShot runAction:[CCScaleTo actionWithDuration:0.5 scale:0.001]];
        
        // shot sound
        [[GDSoundsManager sharedSoundsManager] playSoundForName:@"BasicWeapon"];
    }
    
    [self sweep];
    [self resolveFire];
}

- (void) sweep
{
    // sweep through object lists looking for ones to cull
    // in this case, shots
    NSMutableArray* oldShots = [NSMutableArray array];
    for (GDPlayerShot* aShot in self.playerShots) 
    {
        if (aShot.scale < 0.002)
        {
            [self removeChild:aShot cleanup:YES];
            [oldShots addObject:aShot];
        }
    }
    /*  //make my own, tighter explosion
     if ([oldShots count])
     {
     CGSize size = [[CCDirector sharedDirector] winSize];
     CCParticleExplosion* expl = [[[CCParticleExplosion alloc] init] autorelease];
     expl.position = ccp( size.width /2 , size.height/2 );
     [self addChild:expl z:13];
     }*/
    for (GDPlayerShot* aShot in oldShots) 
    {
        [self.playerShots removeObject:aShot];
    }
    
    // now sweep through enemies
    NSMutableArray* deadEnemies = [NSMutableArray array];
    for (GDEnemyBaseSprite* anEnemy in self.enemySprites)
    {
        if (anEnemy.dead)
        {
            [deadEnemies addObject:anEnemy];
        }
    }
    for (GDEnemyBaseSprite* deadEnenmy in deadEnemies) 
    {
        [self.enemySprites removeObject:deadEnenmy];
        [self removeChild:deadEnenmy cleanup:YES];
    }
}

- (void) resolveFire
{
    // stupid brute force test of all player shots with all enemies...
    for (CCSprite* aShot in self.playerShots) 
    {
        for (GDEnemyBaseSprite* anEnemy in self.enemySprites) 
        {
            // test distance
            float exSize = 8.0;
            CGRect shotRect = [aShot boundingBox]; // get boundingBox to account for rotation and anchorPoint offset
            CGPoint centerShot = CGPointMake(shotRect.origin.x + (shotRect.size.width / 2), shotRect.origin.y + (shotRect.size.height / 2));
            
            float distX = abs(centerShot.x - anEnemy.position.x);
            if (distX <= exSize)
            {
                float distY = abs(centerShot.y - anEnemy.position.y);
                float dist = sqrtf((distX*distX) + (distY*distY));
                if (dist <= exSize)
                {
                    NSLog(@"Got one!");
                    
                }
            }
        }
    }
}

#pragma mark - GDGameScreenProtocol

- (void) addEnemySprite:(id)aSprite
{
    //[aSprite scheduleUpdateWithPriority:3];
    [self.enemySprites addObject:aSprite];
    [self addChild:aSprite z:10];
}

@end
