#import "ClippingNode.h"


@implementation ClippingNode

-(id) init
{
    if ((self = [super init]))
    {
       
    }
    return self;
}

-(void) dealloc 
{
    [super dealloc];
}

-(CGRect) clippingRegion
{
    return clippingRegionInNodeCoordinates;
}

-(void) setClippingRegion:(CGRect)region
{
    // respect scaling
    clippingRegion = CGRectMake(region.origin.x * scaleX_, region.origin.y * scaleY_, 
                                region.size.width * scaleX_, region.size.height * scaleY_);
}

-(void) setScale:(float)newScale
{
    [super setScale:newScale];
    // re-adjust the clipping region according to the current scale factor
    [self setClippingRegion:clippingRegionInNodeCoordinates];
}

-(void) deviceOrientationChanged:(NSNotification*)notification
{
    // re-adjust the clipping region according to the current orientation
    [self setClippingRegion:clippingRegionInNodeCoordinates];
}

-(void) visit
{
    glPushMatrix();
    glEnable(GL_SCISSOR_TEST);
    glScissor(clippingRegion.origin.x + positionInPixels_.x, clippingRegion.origin.y + positionInPixels_.y,
              clippingRegion.size.width, clippingRegion.size.height);
    
    [super visit];
    
    glDisable(GL_SCISSOR_TEST);
    glPopMatrix();
}

@end