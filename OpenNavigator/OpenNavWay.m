//
//  OpenNavWay.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavWay.h"

@implementation OpenNavWay

@synthesize wayid, nodes;

- (id) initWithID:(int)idvalue
{
    if (self = [super init]) {
        wayid = idvalue;
        nodes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addNode:(long)nodeid
{
    [nodes addObject:[NSNumber numberWithLong:nodeid]];
}

- (Boolean) isArea
{
    return nodes[0] == nodes[[nodes count]-1];
}
@end
