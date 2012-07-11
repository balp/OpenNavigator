//
//  OpenNavNode.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavNode.h"

@implementation OpenNavNode

@synthesize lat, lon, nodeid;

- (id) initNodeWithID: (long)nid onLat: (double)nlat lon: (double)nlon
{
    if (self = [super init]) {
        nodeid = nid;
        lat = nlat;
        lon = nlon;

    }
    return self;
}


@end
