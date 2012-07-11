//
//  OpenNavWay.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenNavOSMObject.h"

@interface OpenNavWay : OpenNavOSMObject
@property (readonly) long wayid;
@property (readonly,strong) NSMutableArray* nodes;

- (id) initWithID:(int)idvalue;
- (void) addNode:(long)nodeid;
@end
