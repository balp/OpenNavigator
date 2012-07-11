//
//  OpenNavNode.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenNavOSMObject.h"

@interface OpenNavNode : OpenNavOSMObject


@property (readonly) double lat;
@property (readonly) double lon;
@property (readonly) long nodeid;

- (id) initNodeWithID: (long)nodeid onLat: (double)lat lon: (double)lon;


@end
