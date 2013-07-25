//
//  OpenNavOsmParser.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@class OpenNavNode;
@class OpenNavWay;
@class OpenNavOSMObject;

@interface OpenNavOsmParser : NSObject <NSXMLParserDelegate>
{
    @private
    NSMutableDictionary* _nodes;
    NSMutableDictionary* _ways;
    OpenNavNode* _currentNode;
    OpenNavOSMObject* _curentObject;
    OpenNavWay* _currentWay;
}
@property (readonly,strong) NSDictionary* ways;
@property (readonly,strong) NSDictionary* nodes;

- (void) parseOSMData:(NSData*)data;
- (OpenNavNode*) getNodeByID:(long)nodeid;
- (OpenNavWay*) getWayByID:(long)wayid;

@end
