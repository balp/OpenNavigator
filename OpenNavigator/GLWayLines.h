//
//  GLWayLines.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-25.
//
//

#import "GLWay.h"

@interface GLWayLines : GLWay
{
@protected
    NSDictionary* _nodes;
    NSMutableDictionary* _indexes;
    GLushort* _wayIndices;
    GLushort* _wayShortIndices;
    GLdouble* _wayNodes;
    size_t _bufferSize;
    NSUInteger _count;
//    OpenNavWay* _navway;
}
- (void) setLineProperties;
- (void) renderLine;

@end
