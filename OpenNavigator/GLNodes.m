//
//  GLNodes.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-24.
//
//

#import "GLNodes.h"
#import "OpenNavNode.h"


@interface GLNodes (hidden)
-(void) finalize;
@end


@implementation GLNodes
@synthesize nodeVertices = _nodeVertices;
@synthesize bufferSize = _bufferSize;


- (id) initWithNodes:(NSDictionary*)nodes andBounds:(NSRect)rect
{
    if (self = [super init]) {
        _nodes = nodes;
        _indexes = [[NSMutableDictionary alloc] initWithCapacity:[nodes count]];
        _bufferSize = [nodes count] * sizeof(GLdouble) * 3;
        _nodeVertices = malloc(_bufferSize);
        min_lat = NSMinX(rect);
        max_lat = NSMaxX(rect);
        min_lon = NSMinY(rect);
        max_lon = NSMaxY(rect);
        unsigned short cnt = 0;
//        for (OpenNavNode* node in [nodes allValues]) {
//            if([node lat] < min_lat) {
//                min_lat = [node lat];
//            }
//            if([node lat] > max_lat) {
//                max_lat = [node lat];
//            }
//            if([node lon] < min_lon) {
//                min_lon = [node lon];
//            }
//            if([node lon] > max_lon) {
//                max_lon = [node lon];
//            }
//
//
//        }
        NSLog(@"Nodes: %f,%f  %f,%f", min_lon, min_lat, max_lon, max_lat);
        for (id nodeID in nodes) {
            OpenNavNode* node = [nodes objectForKey:nodeID];
//            NSLog(@"InitWithNode: %@", node);
            _nodeVertices[cnt * 3 + 0] = [self lonToLocal:[node lon]]; // Lon
            _nodeVertices[cnt * 3 + 1] = [self latToLocal:[node lat]]; // Lat
            _nodeVertices[cnt * 3 + 2] = 0.0; // Height
            [_indexes setObject:[NSNumber numberWithInt:cnt] forKey:nodeID];
//            NSLog(@"node %d (%lf, %lf, %lf)", cnt, _nodeVertices[cnt * 3 + 0], _nodeVertices[cnt * 3 + 1], _nodeVertices[cnt * 3 + 2]);
            ++cnt;
        }

    }
    return self;
}

-(void) finalize
{
    free(_nodeVertices);
}

- (NSUInteger)count
{
    return [_indexes count];
}

- (GLdouble)lonToLocal: (double)lon
{
    GLdouble ret_val = -10 + ((lon - min_lon) / (max_lon-min_lon))*20.0;
//    NSLog(@"lonToLocal: %f = %f %f %f == %f == %f", lon, min_lon, max_lon, max_lon-min_lon, (lon - min_lon) / (max_lon-min_lon), ret_val);
    return ret_val;
}
- (GLdouble)latToLocal: (double)lat
{
    GLdouble ret_val = -10+((lat - min_lat)/(max_lat-min_lat)) * 20.0;
//    NSLog(@"latToLocal: %f = %f %f %f == %f == %f", lat, min_lat, max_lat, max_lat-min_lat, (lat - min_lat) / (max_lat-min_lat), ret_val);
    return ret_val;
}

- (GLushort) indexOfNodeWithId: (NSNumber*)nodeid
{
    return [[_indexes objectForKey:nodeid] unsignedShortValue];
}

@end
