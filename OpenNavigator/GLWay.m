//
//  GLWay.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-24.
//
//

#import "GLWay.h"
#import "GLWayHighway.h"
#import "GLWayHidden.h"
#import "GLWayCoastline.h"
#import "GLWayPier.h"
#import "GLWayResidental.h"
#import "GLWayWetland.h"
#import "GLWayBuilding.h"
#import "GLWayWater.h"
#import "GLWayWaterway.h"
#import "GLWayOutlineArea.h"
#import "GLWayFilledArea.h"

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
    } else if ([way haveTag:@"building"]) {
        if ([[way tagValue:@"building"] isEqualToString:@"roof"]) {
            return [[GLWayBuilding alloc] initWithWay:way usingNodes:nodes andColor:[NSColor colorWithCalibratedRed:0.8 green:0.5 blue:0.5 alpha:0.5]];
        }
        return [[GLWayBuilding alloc] initWithWay:way usingNodes:nodes andColor:[NSColor colorWithCalibratedRed:0.7 green:0.4 blue:0.4 alpha:0.5]];
    } else if ([way haveTag:@"natural"]) {
        if ([[way tagValue:@"natural"] isEqualToString:@"coastline"]) {
            if ([way haveTag:@"place"]) {
                return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.6 blue:0.2 alpha:0.5]];
            }
            return [[GLWayCoastline alloc] initWithWay:way usingNodes:nodes];
        }
        if ([[way tagValue:@"natural"] isEqualToString:@"wetland"]) {
            return [[GLWayWetland alloc] initWithWay:way usingNodes:nodes];
        }
        if ([[way tagValue:@"natural"] isEqualToString:@"water"]) {
            return [[GLWayWater alloc] initWithWay:way usingNodes:nodes];
        }
        if ([[way tagValue:@"natural"] isEqualToString:@"grassland"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.7 blue:0.2 alpha:0.5]];
        }
        if ([[way tagValue:@"natural"] isEqualToString:@"wood"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.6 blue:0.2 alpha:0.5]];
        }
        if ([[way tagValue:@"natural"] isEqualToString:@"beach"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.6 green:0.6 blue:0.2 alpha:0.5]];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"amenity"]) {
        if ([[way tagValue:@"amenity"] isEqualToString:@"parking"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.3 blue:0.8 alpha:0.5]];
        }
        if ([[way tagValue:@"amenity"] isEqualToString:@"school"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.8 green:0.3 blue:0.8 alpha:0.5]];
        }
        if ([[way tagValue:@"amenity"] isEqualToString:@"kindergarten"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.7 green:0.3 blue:0.7 alpha:0.5]];
        }
        if ([[way tagValue:@"amenity"] isEqualToString:@"grave_yard"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"man_made"]) {
        if ([[way tagValue:@"man_made"] isEqualToString:@"pier"]) {
            return [[GLWayPier alloc] initWithWay:way usingNodes:nodes];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"landuse"]) {
        if ([[way tagValue:@"landuse"] isEqualToString:@"residential"]) {
            return [[GLWayResidental alloc] initWithWay:way usingNodes:nodes];
        }
        if ([[way tagValue:@"landuse"] isEqualToString:@"forest"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.5 blue:0.2 alpha:0.5]];
        }
        if ([[way tagValue:@"landuse"] isEqualToString:@"farmland"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.4 green:0.6 blue:0.2 alpha:0.5]];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"boundary"]) {
        if ([[way tagValue:@"boundary"] isEqualToString:@"national_park"]) {
            return [[GLWayOutlineArea alloc] initWithWay:way usingNodes:nodes andColor:[NSColor colorWithCalibratedRed:0.4 green:0.7 blue:1.0 alpha:0.5] andWidth:1.0];
        }
        if ([[way tagValue:@"boundary"] isEqualToString:@"administrative"]) {
            GLfloat width = 7;
            if ([way haveTag:@"admin_level"]) {
                NSString* lvl = [way tagValue:@"admin_level"];
                width = 10.0 - [lvl intValue];
            }
            return [[GLWayOutlineArea alloc] initWithWay:way usingNodes:nodes andColor:[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.5] andWidth:width];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"leisure"]) {
        if ([[way tagValue:@"leisure"] isEqualToString:@"pitch"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.6 blue:0.0 alpha:0.5]];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"sport"]) {
        if ([[way tagValue:@"sport"] isEqualToString:@"tennis"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.6 blue:0.2 alpha:0.5]];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"waterway"]) {
        return [[GLWayWaterway alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"route"]) {
        if ([[way tagValue:@"route"] isEqualToString:@"ferry"]) {
            return [[GLWayLines alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.6 blue:0.2 alpha:0.5] andWidth:2.0];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if ([way haveTag:@"area"]) {
        if ([[way tagValue:@"area"] isEqualToString:@"yes"]) {
            return [[GLWayFilledArea alloc] initWithWay:way usingNodes:nodes  andColor:[NSColor colorWithCalibratedRed:0.2 green:0.2 blue:0.2 alpha:0.5]];
        }
        return [[GLWay alloc] initWithWay:way usingNodes:nodes];
    } else if([way haveTag:@"source"] && ([[way tags] count] == 1)) {
        return [[GLWayHidden alloc] initWithWay:way usingNodes:nodes];
    }
    if ([[way tags] count] < 1) {
        return [[GLWayHidden alloc] initWithWay:way usingNodes:nodes];
    }
    return [[GLWay alloc] initWithWay:way usingNodes:nodes];
}


@end
