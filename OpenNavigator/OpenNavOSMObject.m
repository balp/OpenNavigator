//
//  OpenNavOSMObject.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavOSMObject.h"

@implementation OpenNavOSMObject

- (id) init
{
    if (self = [super init]) {
        _tags = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

- (BOOL) haveTag:(NSString*)tag
{
    return ([_tags objectForKey:tag] != nil);
}

- (void) setTag:(NSString*)key to:(NSString*)value
{
    [_tags setObject:value forKey:key];
}
- (NSString*) tagValue:(NSString*)tag
{
    return [_tags objectForKey:tag];
}

@end
