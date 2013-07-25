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
    GLfloat* _nodeVertices;
    double min_lat;
    double max_lat;
    double min_lon;
    double max_lon;
    size_t _bufferSize;
}
@property (readonly) GLfloat* nodeVertices;
@property (readonly) size_t bufferSize;


- (id) initWithNodes:(NSDictionary*)nodes;
- (NSUInteger)count;
- (GLfloat)lonToLocal: (double)lon;
- (GLfloat)latToLocal: (double)lat;
- (GLushort) indexOfNodeWithId: (NSNumber*)nodeid;


@end
