//
//  GLNodes.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-24.
//
//

#import <Foundation/Foundation.h>

@interface GLNodes : NSObject
{
@private
    NSDictionary* _nodes;
    NSMutableDictionary* _indexes;
    GLdouble* _nodeVertices;
    double min_lat;
    double max_lat;
    double min_lon;
    double max_lon;
    size_t _bufferSize;
}
@property (readonly) GLdouble* nodeVertices;
@property (readonly) size_t bufferSize;


- (id) initWithNodes:(NSDictionary*)nodes andBounds:(NSRect)rect;
- (NSUInteger)count;
- (GLdouble)lonToLocal: (double)lon;
- (GLdouble)latToLocal: (double)lat;
- (GLushort) indexOfNodeWithId: (NSNumber*)nodeid;


@end
