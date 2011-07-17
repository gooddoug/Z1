//
//  GDInputManager.h
//  MenuTest
//
//  Created by Doug Whitmore on 7/3/11.
//  Copyright 2011 Apple Computer Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GDInputManager : NSObject 
{
    
}

// actual properties...
@property BOOL right;
@property BOOL left;
@property BOOL fire;
@property BOOL pause;

- (BOOL) handleKeyDown:(NSEvent*) event;
- (BOOL) handleKeyUp:(NSEvent*) event;
// if we hook up other input later, here is where we'd do it

@end
