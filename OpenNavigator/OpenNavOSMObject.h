//
//  OpenNavOSMObject.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenNavOSMObject : NSObject
{
@private
    NSMutableDictionary* _tags;
}

- (BOOL) haveTag:(NSString*)tag;
- (void) setTag:(NSString*)key to:(NSString*)value;
- (NSString*) tagValue:(NSString*)tag;

@end
