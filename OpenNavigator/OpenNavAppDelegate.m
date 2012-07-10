//
//  OpenNavAppDelegate.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavAppDelegate.h"
#import "OpenNavOpenGLView.h"

@implementation OpenNavAppDelegate

@synthesize window = _window;
@synthesize oglview = _oglview;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSLog(@"applicationDidFinishLaunching: window %@ oglview %@", _window, _oglview);
    [_oglview setUp];
    //NSString* apiUrl = @"http://www.overpass-api.de/api/interpreter?data=(node(51.249,7.148,51.251,7.152);rel(bn)->.rels;way(bn);rel(bw););out;;";
    // 64.7359792, 21.2130679, 64.7245458, 21.2271024
    NSString* query = [NSString stringWithFormat:@"(node(%f,%f,%f,%f);<;>;);out body;", 64.7245458, 21.2130679, 64.7359792,   21.2271024];
    NSString* apiUrl = [NSString stringWithFormat:@"http://overpass.osm.rambler.ru/cgi/interpreter?data=%@",
                        [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSLog(@"URL: %@, %@", apiUrl, query);
    NSURL* url = [NSURL URLWithString:apiUrl];
    NSLog(@"Open URL: %@", url);
    
    NSStringEncoding encoding;
    NSString *data = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:NULL];
    NSLog(@"Got data %@", data);
}

@end
