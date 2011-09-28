//
//  Z1GameScreen.m
//  Z1_game
//
//  Created by Doug Whitmore on 7/19/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "SimpleAudioEngine.h"

#import "Z1GameScreen.h"
#import "Z1LevelManager.h"
#import "Z1Player.h"
#import "GDInputManager.h"
#import "GDPlayerShot.h"
#import "GDEnemySpriteEmitter.h"
#import "GDEffectProtocol.h"
#import "GDSoundsManager.h"

#define PLAYER_ROT_FACTOR 100

@interface Z1GameScreen ()

@property (nonatomic, retain) CCSprite* backgroundSprite;
@property (nonatomic, retain) NSArray* spawners;
@property float time;
@property int spawnerIndex;
@property (nonatomic, retain) Z1GameOverOverlay* gameOverScreen;
@property (nonatomic, retain) CCLabelAtlas* scoreLabel;
@property BOOL started;
@property BOOL gameOver;

- (void) sweepForDead;
- (void) resolveFire;
- (void) playerDied;
- (void) endLevel;
- (void) resolvePlayerCollision;
- (void) handleInput:(ccTime)dt;
- (void) checkSpawners:(ccTime)dt;

@end

@implementation Z1GameScreen

@synthesize inputManager = _inputManager, playerSprite = _playerSprite, enemySprites = _enemySprites;
@synthesize playerShots = _playerShots, effects = _effects, time = _time, spawnerIndex = _spawnerIndex, started = _started;

@synthesize levelDescription = _levelDescription, backgroundSprite = _backgroundSprite, spawners = _spawners, gameOverScreen = _gameOverScreen, gameOver = _gameOver, scoreLabel = _scoreLabel;

+(CCScene*) scene
{
    CCScene *scene = [CCScene node];
	
    // cheat this first time
	Z1GameScreen *layer = [[[Z1GameScreen alloc] initWithFile:@"simple_test"] autorelease];
	
	[scene addChild: layer];
	
	return scene;
}

+ (CCScene*) sceneWithDictionary:(NSDictionary*)levelDict
{
    CCScene *scene = [CCScene node];
	
    // cheat this first time
	Z1GameScreen *layer = [[[Z1GameScreen alloc] initWithDictionary:levelDict] autorelease];
	
	[scene addChild: layer];
	
	return scene;
}

- (void) dealloc
{
    [_inputManager release];
    [_playerShots release];
    [_enemySprites release];
    [_effects release];
    [_levelDescription release];
    [_backgroundSprite release];
    
    [super dealloc];
}

- (id) initWithFile:(NSString*)inFile
{
    NSString* levelPath = [[NSBundle mainBundle] pathForResource:inFile ofType:@"z1level"];
    if (!levelPath)
    {
        // find a folder next to the app named levels?
        
    }
    NSDictionary* levelDescription = [NSDictionary dictionaryWithContentsOfFile:levelPath];
    return [self initWithDictionary:levelDescription];
}

- (id) initWithDictionary:(NSDictionary*)levelDict
{
    if (( self = [super initWithColor:ccc4(0, 0, 0, 255)] ))
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        self.isKeyboardEnabled = YES;
        self.started = NO;
        self.inputManager = [[[GDInputManager alloc] init] autorelease];
        [self scheduleUpdate];
        self.enemySprites = [NSMutableArray array];
        self.playerShots = [NSMutableSet set];
                
        self.levelDescription = levelDict;
        
        // player ship
        NSString* shipSprite = [self.levelDescription objectForKey:@"shipSprite"];
        if (!shipSprite)
            shipSprite = @"ship2_64x64.png";
            
        self.playerSprite = [CCSprite spriteWithFile:shipSprite];
        self.playerSprite.flipY = YES;
        
        self.playerSprite.anchorPoint = ccp( 0.65 , 6.0 );
        self.playerSprite.position = ccp( size.width /2 , size.height/2 );
        
        [self addChild:self.playerSprite z:20];
            
        /*NSString* backgroundName = [self.levelDescription objectForKey:@"background"];
        if (backgroundName)
        {
            self.backgroundSprite = [CCSprite spriteWithFile:[levelPath stringByAppendingPathComponent:backgroundName]];
            self.backgroundSprite.position = ccp(size.width / 2.0f, size.height / 2.0f  + 10.0);
            [self addChild:self.backgroundSprite z:0];
            [self.backgroundSprite runAction:[CCScaleBy actionWithDuration:200 scale:5]];
        }*/
        NSMutableArray* tempEffects = [NSMutableArray array];
        for (NSDictionary* anEffect in [self.levelDescription objectForKey:@"effects"])
        {
            [tempEffects addObject:[[[NSClassFromString([anEffect objectForKey:@"name"]) alloc] initWithEffectDictionary:anEffect] autorelease]];
        }
        self.effects = tempEffects;
        self.spawners = [self.levelDescription objectForKey:@"spawners"];
        
        // 
        CCTexture2DPixelFormat currentFormat = [CCTexture2D defaultAlphaPixelFormat];
		[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
		self.scoreLabel = [CCLabelAtlas labelWithString:[NSString stringWithFormat:@"%d", [Z1Player sharedPlayer].score] charMapFile:@"fps_images.png" itemWidth:16 itemHeight:24 startCharMap:'.'];
		[CCTexture2D setDefaultAlphaPixelFormat:currentFormat];
        self.scoreLabel.position = ccp(100.0, 700.0);
        [self addChild:self.scoreLabel];
        
        self.started = YES;
    }
    return self;
}

- (BOOL) ccKeyDown:(NSEvent *)event
{
    if (self.started)
        return [self.inputManager handleKeyDown:event];
    return NO;
}


- (BOOL) ccKeyUp:(NSEvent *)event
{
    if (self.started) 
    {
        return [self.inputManager handleKeyUp:event];
    }
    return NO;
}

- (void) handleInput:(ccTime)dt  
{
    if (self.inputManager.pause)
    {
        [[GDSoundsManager sharedSoundsManager] playMusicForSceneNamed:@"mainMenu"];
        [[CCDirector sharedDirector] popScene];
    }
    
    BOOL moved = FALSE;
    // quick and dirty test...
    if (self.inputManager.left)
    {
        /*CGPoint currPos = self.playerSprite.position;
         CGPoint newPos = ccp(currPos.x + (dt * 100), currPos.y);
         self.playerSprite.position = newPos;*/
        float rot = self.playerSprite.rotation + (PLAYER_ROT_FACTOR * dt);
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
        float rot = self.playerSprite.rotation - (PLAYER_ROT_FACTOR * dt);
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
        GDPlayerShot* aShot = [GDPlayerShot shotAtRotation:self.playerSprite.rotation anchorPoint:ccp(0.5, 19.0)];
        aShot.position = ccp( size.width /2 , size.height/2 );
        
        [self addChild:aShot z:10];
        [self.playerShots addObject:aShot];
        [aShot runAction:[CCScaleTo actionWithDuration:1.0 scale:0.001]];
        
        // shot sound
        [[GDSoundsManager sharedSoundsManager] playSoundForName:@"BasicWeapon"];
    }
}

- (void) update:(ccTime)dt
{
    if (!self.started)
        return;
    
    [self checkSpawners:dt];
    [self sweepForDead];
    
    if (!self.gameOver) 
    {
        [self resolveFire];
        [self resolvePlayerCollision];
        
        [self handleInput: dt];
    }
}

- (void) sweepForDead
{
    // sweep through object lists looking for ones to cull
    // in this case, shots
    NSMutableArray* oldShots = [NSMutableArray array];
    for (GDPlayerShot* aShot in self.playerShots) 
    {
        if (aShot.scale < 0.002 || aShot.hitSomething)
        {
            [self removeChild:aShot cleanup:YES];
            [oldShots addObject:aShot];
        }
    }
    
    for (GDPlayerShot* aShot in oldShots) 
    {
        [self.playerShots removeObject:aShot];
    }
    
    // now sweep through enemies
    NSMutableArray* deadEnemies = [NSMutableArray array];
    for (GDUnboundSprite* anEnemy in self.enemySprites)
    {
        if (anEnemy.dead)
        {
            [deadEnemies addObject:anEnemy];
        }
    }
    
    for (GDUnboundSprite* deadEnenmy in deadEnemies) 
    {
        [self.enemySprites removeObject:deadEnenmy];
        [self removeChild:deadEnenmy cleanup:YES];
    }
}

- (void) deleteExplosion:(id)node
{
	[self removeChild:node cleanup:TRUE];
}

- (void) newExplosionAtPoint:(CGPoint)aPoint
{
	CCSprite* explosionSprite = [CCSprite spriteWithFile:@"fire.png"];
	explosionSprite.position = aPoint;
	ccColor3B spriteColor = ccc3((arc4random() % 127) + 127, (arc4random() % 255), 0); // red and yellow randoms
	explosionSprite.color = spriteColor;
	
	[self addChild:explosionSprite z:2];
	
	id scaleAction = [CCScaleTo actionWithDuration:0.25 scale:5.0];
	id fadeAction = [CCFadeOut actionWithDuration:0.25];
	id deleteAction = [CCCallFuncN actionWithTarget:self selector:@selector(deleteExplosion:)];
	
	[explosionSprite runAction:[CCSequence actions:scaleAction, fadeAction, deleteAction, nil]];
	
	// Now the explosion particle system
	CCParticleSystem* emitter = [[CCParticleExplosion alloc] initWithTotalParticles:50];
	emitter.life = 0.25;
	emitter.lifeVar = 0.125;
	[self addChild:emitter z:0];
	
	emitter.texture = [[CCTextureCache sharedTextureCache] addImage: @"stars.png"];
	
	emitter.autoRemoveOnFinish = YES;
	emitter.position = aPoint;
    [[GDSoundsManager sharedSoundsManager] playSoundForName:@"explosion"];
}

- (void) playerExplosionAtPoint:(CGPoint)aPoint
{
    [self newExplosionAtPoint:aPoint];
    // now overlay a ring...
    CCSprite* ringSprite = [CCSprite spriteWithFile:@"ring.png"];
    
    CCScaleTo* scaleAction = [CCScaleTo actionWithDuration:0.15 scale:1.5];
    CCFadeOut* fadeAction = [CCFadeOut actionWithDuration:0.5];
    CCCallFuncN* deleteAction = [CCCallFuncN actionWithTarget:self selector:@selector(deleteExplosion:)];
    
    ringSprite.position = aPoint;
    [ringSprite runAction:[CCSequence actions:scaleAction, fadeAction, deleteAction, nil]];
    [self addChild:ringSprite z:3];
}

- (void) resolveFire
{
    // stupid brute force test of all player shots with all enemies...
    for (GDPlayerShot* aShot in self.playerShots) 
    {
        float exSize = 15.0; // be smarter about this later
        CGRect shotRect = [aShot boundingBox]; // get boundingBox to account for rotation and anchorPoint offset
        CGPoint centerShot = CGPointMake(shotRect.origin.x + (shotRect.size.width / 2), shotRect.origin.y + (shotRect.size.height / 2));
        
        for (GDBasicSprite* anEnemy in self.enemySprites) 
        {
            CGRect enemyRect = [anEnemy boundingBox]; // get boundingBox to account for rotation and anchorPoint offset
            CGPoint centerEnemy = CGPointMake(enemyRect.origin.x + (enemyRect.size.width / 2), enemyRect.origin.y + (enemyRect.size.height / 2));

            // test distance
            float distX = abs(centerShot.x - centerEnemy.x);
            if (distX <= exSize)
            {
                float distY = abs(centerShot.y - centerEnemy.y);
                float dist = sqrtf((distX*distX) + (distY*distY));
                if (dist <= exSize)
                {
                    anEnemy.dead = YES;
                    aShot.hitSomething = YES;
                                        
                    [self newExplosionAtPoint:centerEnemy];
                    Z1Player* player = [Z1Player sharedPlayer];
                    player.score += 100;
                    [self.scoreLabel setString:[NSString stringWithFormat:@"%4d", player.score]];
                }
            }
        }
    }
}

- (void) resolvePlayerCollision
{
    CGRect playerRect = [self.playerSprite boundingBox];
    
    // again simple brute force...
    for (GDBasicSprite* anEnemy in self.enemySprites) 
    {
        CGRect enemyRect = [anEnemy boundingBox]; // get boundingBox to account for rotation and anchorPoint offset
        CGPoint centerEnemy = CGPointMake(enemyRect.origin.x + (enemyRect.size.width / 2), enemyRect.origin.y + (enemyRect.size.height / 2));
        // check whether the enemy's center is in the bounding box (makes for a small kill box for now)
        if (CGRectContainsPoint(playerRect, centerEnemy))
        {
            NSLog(@"BOOM!");
            anEnemy.dead = YES;
            [self newExplosionAtPoint:centerEnemy];
            CGPoint centerPlayer = CGPointMake(playerRect.origin.x + (playerRect.size.width/2), playerRect.origin.y + (playerRect.size.height / 2));
            [self playerExplosionAtPoint:centerPlayer];
            [self playerDied];
        }
    }
}

- (void) checkSpawners:(ccTime)dt
{
    self.time = self.time + dt;
    if (self.spawnerIndex < [self.spawners count])
    {
        NSDictionary* nextSpawner = [self.spawners objectAtIndex:self.spawnerIndex];
        if (self.time > [[nextSpawner objectForKey:@"when"] intValue])
        {
            // create the spawner
            GDEnemySpriteEmitter* emitter = [[[GDEnemySpriteEmitter alloc] initWithDictionary:nextSpawner] autorelease];
            // schedule updates
            [emitter scheduleUpdate];
            // add as child
            [self addChild:emitter];
            self.spawnerIndex = self.spawnerIndex + 1;
        }
    } else 
    {
        if (self.time > ([[[self.spawners lastObject] objectForKey:@"when"] intValue] + [[[self.spawners lastObject] objectForKey:@"howLong"] intValue] + 10))
        {
            if (!self.gameOver)
            {
                [self endLevel];
            }
        }
    }
}

#pragma mark - implemented accessors

- (void) setEffects:(NSArray *)effects
{
    if (effects == _effects)
    {
        return;
    }
    NSArray* temp = [effects retain];
    [_effects release];
    _effects = temp;
    
    // add them as children
    int i = 1;
    for (CCNode* aNode in _effects) 
    {
        [self addChild:aNode z:i];
        i++;
    }
}

- (NSArray*) effects
{
    return _effects;
}


#pragma mark - GDGameScreenProtocol

- (void) addEnemySprite:(id)aSprite
{
    //[aSprite scheduleUpdateWithPriority:3];
    [self.enemySprites addObject:aSprite];
    [self addChild:aSprite z:10];
}

- (void) playerDied
{
    self.gameOverScreen = [[[Z1GameOverOverlay alloc] initAndFinsihed:NO] autorelease];
    [self addChild:self.gameOverScreen z:100];
    self.gameOver = YES;
    [self removeChild:self.playerSprite cleanup:YES];
    CCDelayTime* delayEndAction = [CCDelayTime actionWithDuration:8];
    CCCallFunc* popSceneAction = [CCCallFunc actionWithTarget:self selector:@selector(moveOn:)];
    CCFadeOut* fadeOutAction = [CCFadeOut actionWithDuration:2.0];
    [self runAction:[CCSequence actions:delayEndAction, fadeOutAction, popSceneAction, nil]];

}

- (void) moveOn:(id) sender
{
    [[CCDirector sharedDirector] popScene];
    [[GDSoundsManager sharedSoundsManager] playMusicForSceneNamed:@"mainMenu"];
}

- (void) startLevel
{
    self.started = YES;
    // background music
    NSString* backgroundMusicName = [self.levelDescription objectForKey:@"backgroundMusic"];
    if(!backgroundMusicName)
        backgroundMusicName = @"Run_3_minute_edit.mp3";
    [[GDSoundsManager sharedSoundsManager] playMusicFromFilename:backgroundMusicName];
}

- (void) endLevel
{
    BOOL endGame = !([[Z1LevelManager sharedLevelManager] moveToNextLevel]);
    if (endGame)
    {
        self.gameOverScreen = [[[Z1GameOverOverlay alloc] initAndFinsihed:YES] autorelease];
        [self addChild:self.gameOverScreen z:100];
        self.gameOver = YES;
        [self removeChild:self.playerSprite cleanup:YES];
    }
}

@end
