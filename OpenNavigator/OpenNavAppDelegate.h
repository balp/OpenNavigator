//
//  OpenNavAppDelegate.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class OpenNavOpenGLView;
@class OpenNavOsmParser;

@interface OpenNavAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet OpenNavOpenGLView *oglview;
@property (readonly, strong) OpenNavOsmParser* parser;

@end
