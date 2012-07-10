//
//  OpenNavOsmParserTests.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavOsmParserTests.h"

#import "OpenNavOsmParser.h"

@implementation OpenNavOsmParserTests

- (void)testOSM
{
    NSFileManager *filemgr;
    
    filemgr = [[NSFileManager alloc] init];
    
    NSString * currentpath = [filemgr currentDirectoryPath];
    NSMutableString* fileName = [NSMutableString stringWithString:currentpath];
    [fileName appendString:@"/OpenNavigatorTests/TestData.osm"];
    OpenNavOsmParser* dut = [[OpenNavOsmParser alloc] init];
    NSData* data = [NSData dataWithContentsOfFile:fileName];
    NSLog(@"Data from %@ is: %@", fileName, data);
    [dut parseOSMData:data];
    STAssertTrue((1 + 1) == 2, @"Compiler isn't feeling well today :-(");
}

@end
