//
//  GLWay.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-24.
//
//

#import "GLWay.h"
#import "GLWayHighway.h"
#import "GLWayCoastline.h"
#import "GLWayPier.h"
#import "GLWayLanduse.h"
#import "GLWayWetland.h"

#import "OpenNavNode.h"
#import "OpenNavWay.h"
#import "GLNodes.h"

//@interface GLWay (hidden)
//-(void) finalize;
//@end

@implementation GLWay


- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    if (self = [super init]) {
        _navway = way;
    }
    return self;
}

- (void)render
{
    NSLog(@"render:+++");
    for (id tag in [_navway tags]) {
        NSLog(@"render unkown: %@:%@", tag,[_navway tagValue:tag]);
    }
    NSLog(@"render:---");
}

+ (GLWay*) createFromWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    if ([way haveTag:@"highway"]) {
        return [[GLWayHighway alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"natural"]) {
        if ([[way tagValue:@"natural"] isEqualToString:@"coastline"]) {
            return [[GLWayCoastline alloc] initWithWay:way usingNodes:nodes];
        }
        if ([[way tagValue:@"natural"] isEqualToString:@"wetland"]) {
            return [[GLWayWetland alloc] initWithWay:way usingNodes:nodes];
        }
    } else if ([way haveTag:@"man_made"]) {
        if ([[way tagValue:@"man_made"] isEqualToString:@"pier"]) {
            return [[GLWayPier alloc] initWithWay:way usingNodes:nodes];
        }
    } else if ([way haveTag:@"landuse"]) {
        if ([[way tagValue:@"landuse"] isEqualToString:@"residential"]) {
            return [[GLWayLanduse alloc] initWithWay:way usingNodes:nodes];
        }
    }
    return [[GLWay alloc] initWithWay:way usingNodes:nodes];
}


@end
