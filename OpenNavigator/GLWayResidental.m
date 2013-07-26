//
//  GLWayLanduse.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-25.
//
//

#import "GLWayResidental.h"
@implementation GLWayResidental

- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    if (self = [super initWithWay:way usingNodes:nodes andColor:[NSColor colorWithCalibratedRed:0.8f green:0.5f blue:0.2f alpha:0.5f]]) {
    }
    return self;
}

@end
