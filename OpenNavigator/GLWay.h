//
//  GLWay.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-24.
//
//

#import <Foundation/Foundation.h>

@class GLNodes;
@class OpenNavWay;

@interface GLWay : NSObject
{
@protected
    int _priority;
    OpenNavWay* _navway;
    GLNodes* _nodes;
}
@property (readonly) int priority;
@property (readonly) OpenNavWay* navway;
@property (readonly) GLNodes* nodes;

- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes;

- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes andPriority:(int) priority;
- (void)render;

+ (GLWay*) createFromWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes;


@end
