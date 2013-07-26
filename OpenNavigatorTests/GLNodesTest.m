//
//  GLNodesTest.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-24.
//
//

#import "GLNodesTest.h"
#import "GLNodes.h"
#import "GLWay.h"

#import "OpenNavOsmParser.h"
#import "OpenNavNode.h"
#import "OpenNavWay.h"


@implementation GLNodesTest

- (void)setUp
{
    [super setUp];

    NSFileManager *filemgr;

    filemgr = [[NSFileManager alloc] init];

    NSString * currentpath = [filemgr currentDirectoryPath];
    NSMutableString* fileName = [NSMutableString stringWithString:currentpath];
    [fileName appendString:@"/OpenNavigatorTests/TestData.osm"];
    navParser = [[OpenNavOsmParser alloc] init];
    NSData* data = [NSData dataWithContentsOfFile:fileName];
    // NSLog(@"Data from %@ is: %@", fileName, data);
    [navParser parseOSMData:data];
}


- (void)testInitWithNodes
{
    NSRect myrect = NSMakeRect(64.723, 21.21, 0.02, 0.02);
    GLNodes* nodes = [[GLNodes alloc] initWithNodes:[navParser nodes] andBounds:myrect];
    STAssertEquals([[navParser nodes] count], [nodes count], @"Not the same numbers of nodes in parser as in GLNodes.");
    GLdouble *vbo = [nodes nodeVertices];
    STAssertEqualsWithAccuracy(vbo[0], (GLdouble)23.109, 0.0001, @"Firsts Node X is off");
    STAssertEqualsWithAccuracy(vbo[1], (GLdouble)-19.4236, 0.0001, @"Firsts Node Y is off");
    STAssertEqualsWithAccuracy(vbo[2], (GLdouble)0.0, 0.0001, @"Firsts Node z is off");
}



@end
