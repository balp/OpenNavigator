//
//  OpenNavOsmParser.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface OpenNavOsmParser : NSOpenGLView

- (void) parseOSMData:(NSData*)data;
@end
