//
//  GLWayWater.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-26.
//
//

#import "GLWayWater.h"

@implementation GLWayWater

- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    if (self = [super initWithWay:way usingNodes:nodes andColor:[NSColor colorWithCalibratedRed:0.2f green:0.2f blue:0.6f alpha:0.5f]]) {
    }
    return self;
}


@end
