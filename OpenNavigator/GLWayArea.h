//
//  GLWayArea.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-25.
//
//

#import "GLWay.h"

@interface GLWayArea : GLWay
{
@protected
    NSDictionary* _nodes;
    NSMutableDictionary* _indexes;
    GLushort* _wayIndices;
    GLushort* _wayShortIndices;
    GLfloat* _wayNodes;
    size_t _bufferSize;
    NSUInteger _count;
    //    OpenNavWay* _navway;
}
- (void) setAreaProperties;
- (void) renderArea;

@end
