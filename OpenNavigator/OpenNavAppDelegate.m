//
//  OpenNavAppDelegate.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavAppDelegate.h"
#import "OpenNavOpenGLView.h"
#import "OpenNavOsmParser.h"

@implementation OpenNavAppDelegate

@synthesize window = _window;
@synthesize oglview = _oglview;
@synthesize parser = _parser;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSLog(@"applicationDidFinishLaunching: window %@ oglview %@", _window, _oglview);
    [_oglview setUp];
    //NSString* apiUrl = @"http://www.overpass-api.de/api/interpreter?data=(node(51.249,7.148,51.251,7.152);rel(bn)->.rels;way(bn);rel(bw););out;;";
    // 64.7359792, 21.2130679, 64.7245458, 21.2271024
//    NSString* query = [NSString stringWithFormat:@"(node(%f,%f,%f,%f);<;>;);out body;", 64.7245458, 21.2130679, 64.7359792,   21.2271024];
//    NSString* apiUrl = [NSString stringWithFormat:@"http://overpass.osm.rambler.ru/cgi/interpreter?data=%@",
//                        [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
//    NSLog(@"URL: %@, %@", apiUrl, query);
//    NSURL* url = [NSURL URLWithString:apiUrl];
//    NSLog(@"Open URL: %@", url);
//    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSFileManager *filemgr;
//
//    filemgr = [[NSFileManager alloc] init];
//
//    NSString * currentpath = [filemgr currentDirectoryPath];
//
//    NSMutableString* fileName = [NSMutableString stringWithString:currentpath];
//    [fileName appendString:@"/OpenNavigatorTests/TestData.osm"];

    // Test data, Södra Skatan, Usrviken, Skellefteå

    NSData* data = [NSData dataWithContentsOfFile:@"/Users/balp/code/python/test/OpenNavigator/OpenNavigatorTests/TestData.osm"];
    NSRect viewRect = NSMakeRect(64.723, 21.21, 0.02, 0.02);
    [[self oglview] followWay:67528919];

// Test data, Skåpesund, between Orust and Tjörn
//    NSData* data = [NSData dataWithContentsOfFile:@"/Users/balp/Documents/OpenStreetMap/orust_1.osm"];
//    NSRect viewRect = NSMakeRect(58.052, 11.689, 0.03, 0.03);


    _parser = [[OpenNavOsmParser alloc] init];
    [[self parser] parseOSMData:data];
    [[self window] setDelegate:[self oglview]];
    [[self oglview] setViewRect:viewRect];
    [[self oglview] setParser:[self parser]];
}

@end
