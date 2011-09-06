//
//  GDParticleStarfield.h
//  MenuTest
//
//  Created by Doug Whitmore on 6/30/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDEffectProtocol.h"
#import "CCParticleExamples.h"

@interface GDParticleStarfield : CCParticleSun <GDEffectProtocol>
{
    
}

+ (GDParticleStarfield*) starfield;

@end
