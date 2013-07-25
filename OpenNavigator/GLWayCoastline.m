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

- (void) setLineProperties
{
    glColor4f(0.0f, 0.0f, .9f, 1.0f);
    glLineWidth(1.5);
    glLineStipple(1, 0xffff);
}

@end
