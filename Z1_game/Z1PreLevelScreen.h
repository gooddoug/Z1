//
//  Z1PreLevelScreen.h
//  Z1_game
//
//  Created by Doug Whitmore on 9/27/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GDSpriteButton.h"

@interface Z1PreLevelScreen : CCLayer 
{
    NSArray* _scripts;
    NSMutableArray* _scriptNodes;
    int _scriptIndex;
    
    GDSpriteButton* _skipButton;
    CCScene* _gameScene;
}

@property (nonatomic, retain) NSArray* scripts;
@property (nonatomic, retain) NSMutableArray* scriptNodes;
@property int scriptIndex;
@property (nonatomic, retain) GDSpriteButton* skipButton;
@property (nonatomic, retain) CCScene* gameScene;

+(CCScene *) sceneWithFile:(NSString*)inName;

- (id) initWithFile:(NSString*)inName;

- (void) done:(id)sender;
- (void) nextScript;

@end
