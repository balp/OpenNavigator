//
//  GLWayCoastline.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-25.
//
//

#import "GLWayCoastline.h"

#import "OpenNavNode.h"
#import "OpenNavWay.h"
#import "GLNodes.h"

@implementation GLWayCoastline

- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    if (self = [super initWithWay:way usingNodes:nodes andColor:[NSColor colorWithCalibratedRed:0.0f green:0.0f blue:0.9f alpha:1.0f] andWidth:3.0 andPriority:9]) {
    }
    return self;
}


@end
