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
    GLNodes* nodes = [[GLNodes alloc] initWithNodes:[navParser nodes]];
    STAssertEquals([[navParser nodes] count], [nodes count], @"Not the same numbers of nodes in parser as in GLNodes.");
    GLfloat *vbo = [nodes nodeVertices];
    STAssertEqualsWithAccuracy(vbo[0], (GLfloat)0.760981, 0.0001, @"Firsts Node X is off");
    STAssertEqualsWithAccuracy(vbo[1], (GLfloat)0.166839, 0.0001, @"Firsts Node Y is off");
    STAssertEqualsWithAccuracy(vbo[2], (GLfloat)0.0, 0.0001, @"Firsts Node z is off");
}

- (void)testFindWayIndices
{
    GLNodes* nodes = [[GLNodes alloc] initWithNodes:[navParser nodes]];
    GLWay* way = [[GLWay alloc] initWithWay:[navParser getWayByID: 67628281] usingNodes:nodes];
    GLushort* vbo = [way wayIndices];
    STAssertEquals(vbo[0], (GLushort)384, @"First index to be ...");
    STAssertEquals(vbo[1], (GLushort)483, @"Second index to be ...");
    STAssertEquals(vbo[2], (GLushort)483, @"Third index to be ...");
}

- (void)testFindWayShortIndices
{
    GLNodes* nodes = [[GLNodes alloc] initWithNodes:[navParser nodes]];
    GLWay* way = [[GLWay alloc] initWithWay:[navParser getWayByID: 67628281] usingNodes:nodes];
    GLushort* vbo = [way wayShortIndices];
    STAssertEquals(vbo[0], (GLushort)0, @"1 index to be ...");
    STAssertEquals(vbo[1], (GLushort)1, @"2 index to be ...");
    STAssertEquals(vbo[2], (GLushort)1, @"3 index to be ...");
    STAssertEquals(vbo[3], (GLushort)2, @"4 index to be ...");
    STAssertEquals(vbo[4], (GLushort)2, @"5 index to be ...");
    STAssertEquals(vbo[5], (GLushort)3, @"6 index to be ...");
}



@end
