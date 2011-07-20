//
//  HelloWorldLayer.h
//  Z1_game
//
//  Created by Doug Whitmore on 7/17/11.
//  Copyright Good Doug 2011. All rights reserved.
//


#import "cocos2d.h"
#import "GDBaseEffectsScreen.h"

@interface Z1SplashScreen : GDBaseEffectsScreen
{
}

@property (nonatomic, retain) CCScene* menuScreen;

+(CCScene *) scene;

@end
