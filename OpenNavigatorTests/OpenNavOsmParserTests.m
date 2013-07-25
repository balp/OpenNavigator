//
//  OpenNavOsmParserTests.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavOsmParserTests.h"

#import "OpenNavOsmParser.h"
#import "OpenNavNode.h"
#import "OpenNavWay.h"

@implementation OpenNavOsmParserTests

- (void)setUp
{
    [super setUp];
    
    NSFileManager *filemgr;
    
    filemgr = [[NSFileManager alloc] init];
    
    NSString * currentpath = [filemgr currentDirectoryPath];
    NSMutableString* fileName = [NSMutableString stringWithString:currentpath];
    [fileName appendString:@"/OpenNavigatorTests/TestData.osm"];
    dut = [[OpenNavOsmParser alloc] init];
    NSData* data = [NSData dataWithContentsOfFile:fileName];
    // NSLog(@"Data from %@ is: %@", fileName, data);
    [dut parseOSMData:data];
}


- (void)testOSMNode_29129868
{
    OpenNavNode* nd = [dut getNodeByID: 29129868 ];
    STAssertNotNil(nd, @"Didnt find the first node");
    STAssertEquals([nd lat], 64.7749467, @"Not the right latitude for node");
    STAssertEquals([nd lon], 21.1495790, @"Not the right longitude for node");
}


- (void)testOSMNode_29129878
{
    OpenNavNode* nd = [dut getNodeByID: 29129878 ];
    STAssertNotNil(nd, @"Didnt find the first node");
    STAssertEquals([nd lat], 64.7772467, @"Not the right latitude for node");
    STAssertEquals([nd lon], 21.1423890, @"Not the right longitude for node");
}

- (void)testOSMNode_817132095
{
    OpenNavNode* nd = [dut getNodeByID: 817132095 ];
    STAssertNotNil(nd, @"Didnt find the node");
    STAssertEquals([nd lat], 64.7291343, @"Not the right latitude for node");
    STAssertEquals([nd lon], 21.2191690, @"Not the right longitude for node");
    STAssertTrue([nd haveTag:@"traffic_calming"], @"Node doesn't have tag traffic_calming");
    STAssertEqualObjects([nd tagValue:@"traffic_calming"], @"bump", @"traffic_calming isn't bump");

}


- (void)testOSMWay_67528919
{
    OpenNavWay* way = [dut getWayByID: 67628281 ];
    STAssertNotNil(way, @"Didnt find the way");
    STAssertTrue([way haveTag:@"highway"], @"Way mising highway tag");
    STAssertEqualObjects([way tagValue:@"highway"], @"residential", @"way isn't residential");
    STAssertTrue([way haveTag:@"maxspeed"], @"Way mising maxspeed tag");
    STAssertEqualObjects([way tagValue:@"maxspeed"], @"30", @"maxspeed isn't 30");
    STAssertNotNil([way nodes], @"Have nodes.");
    STAssertEquals([[way nodes] count], (size_t)7, @"Elements of nodes");
    STAssertEqualObjects([[way nodes] objectAtIndex:0], [NSNumber numberWithLong:815452396], @"Elements of nodes");
    //STAssertEquals([way nodes]  , 815452396, @"");
    //STAssertEquals([nd lat], 64.7772467, @"Not the right latitude for node");
    //STAssertEquals([nd lon], 21.1423890, @"Not the right longitude for node");
}

- (void)testOSMWays
{
    for(id key in [dut ways]) {
//        NSLog(@"Key: %@", key);
        OpenNavWay* way = [dut getWayByID:[key longValue]];
        STAssertNotNil(way, @"Didnt find the way");
        STAssertNotNil([way nodes], @"Have nodes.");
    }
}

- (void)testOSMNodes
{
    for (id key in [dut nodes]) {
//        NSLog(@"Key node: %@", key);
        OpenNavNode* node = [dut getNodeByID:[key longValue]];
        STAssertNotNil(node, @"Return a unkown ID");
    }
}

@end
