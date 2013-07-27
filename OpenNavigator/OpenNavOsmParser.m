//
//  OpenNavOsmParser.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavOsmParser.h"
#import "OpenNavNode.h"
#import "OpenNavWay.h"

@implementation OpenNavOsmParser

@synthesize ways = _ways;
@synthesize nodes = _nodes;

- (id) init
{
    if (self = [super init]) {
        _nodes = [[NSMutableDictionary alloc] init];
        _ways = [[NSMutableDictionary alloc] init];
        _currentNode = nil;
        _curentObject = nil;
        _currentWay = nil;
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"node"]) {
        NSString* idString = [attributeDict valueForKey:@"id"];
        int idval;
        [[NSScanner scannerWithString:idString] scanInt:&idval];
        double lat;
        [[NSScanner scannerWithString:[attributeDict valueForKey:@"lat"]] scanDouble:&lat];
        double lon;
        [[NSScanner scannerWithString:[attributeDict valueForKey:@"lon"]] scanDouble:&lon];
//        NSLog(@"Node: %d, @ %f, %f", idval, lat, lon);
        OpenNavNode* nd = [[OpenNavNode alloc] initNodeWithID: idval onLat: lat lon: lon];
        [_nodes setObject:nd forKey:[NSNumber numberWithInt:idval]];
        _currentNode = nd;
        _curentObject = nd;
    } else if([elementName isEqualToString:@"tag"]) {
        if (_curentObject != nil) { // Parsing a node
            [_curentObject setTag:[attributeDict valueForKey:@"k"] to:[attributeDict valueForKey:@"v"]];
        }
        
    } else if([elementName isEqualToString:@"way"]) {
        int idval;
        [[NSScanner scannerWithString:[attributeDict valueForKey:@"id"]] scanInt:&idval];
        OpenNavWay* way = [[OpenNavWay alloc] initWithID:idval];
        _currentWay = way;
        _curentObject = way;
        [_ways setObject:way forKey:[NSNumber numberWithInt:idval]];
    } else if([elementName isEqualToString:@"nd"]) {
        if(_currentWay) {
            int refval;
            [[NSScanner scannerWithString:[attributeDict valueForKey:@"ref"]] scanInt:&refval];
            [_currentWay addNode:refval];
        }
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"node"]) {
        _currentNode = nil;
        _curentObject = nil;
    }
    if ([elementName isEqualToString:@"way"]) {
        _currentWay = nil;
        _curentObject = nil;
    }
}

- (void) parseOSMData:(NSData*)data
{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
    
    [parser setDelegate:self];
    [parser parse];
}

- (OpenNavNode*) getNodeByID:(long)nodeid
{
    return [_nodes objectForKey:[NSNumber numberWithLong:nodeid]];
}

- (OpenNavWay*) getWayByID:(long)wayid
{
    return [_ways objectForKey:[NSNumber numberWithLong:wayid]];
}

@end
