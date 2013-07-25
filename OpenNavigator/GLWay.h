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
@private
    NSDictionary* _nodes;
    NSMutableDictionary* _indexes;
    GLushort* _wayIndices;
    GLushort* _wayShortIndices;
    GLfloat* _wayNodes;
    size_t _bufferSize;
    NSUInteger _count;
    OpenNavWay* _navway;
}
//@property (readonly) GLushort* wayIndices;
//@property (readonly) GLfloat* wayNodes;
//@property (readonly) GLushort* wayShortIndices;
//
//@property (readonly) size_t bufferSize;

- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes;
//- (NSUInteger)count;
- (void)render;

+ (GLWay*) createFromWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes;


@end
