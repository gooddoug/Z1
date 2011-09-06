//
//  GDUtilities.m
//  Z1_game
//
//  Created by Doug Whitmore on 9/2/11.
//  Copyright 2011 Good Doug. All rights reserved.
//

#import "GDUtilities.h"

@implementation GDUtilities

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end


ccColor4F dictToColor(NSDictionary* inDict)
{
    float red = [[inDict objectForKey:@"r"] floatValue];
    float green = [[inDict objectForKey:@"g"] floatValue];
    float blue = [[inDict objectForKey:@"b"] floatValue];
    float alpha = [[inDict objectForKey:@"a"] floatValue];
    
    ccColor4F val = {red, green, blue, alpha};
    return val;
}