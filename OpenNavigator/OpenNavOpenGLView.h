//
//  OpenNavOpenGLView.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

#include <OpenGL/gl.h>
@class OpenNavOsmParser;
@class GLNodes;
//#import "OpenNavOsmParser.h"


@interface OpenNavOpenGLView : NSOpenGLView<NSWindowDelegate>
{
@private
    GLuint verticesVBO;
    GLuint indicesVBO;
    GLuint lineVerticesVBO;
    GLuint lineIndicesVBO;
    Boolean started;
    OpenNavOsmParser* _parser;
    GLdouble* nodeCorners;
    GLNodes* myNodes;
    NSRect _viewRect;
    NSMutableArray* _glways;
    long _way;
    long _wayIndex;
    GLfloat transX;
    GLfloat transY;
}
@property NSRect viewRect;

- (void) setViewRect: (NSRect) area;
- (void) viewPos: (NSPoint)center andZoom: (double)zoom;
- (void) setParser: (OpenNavOsmParser*) parser;
- (void) followWay: (long)wayId;
- (void) drawRect: (NSRect) bounds;
- (void) setUp;
- (void) update;
@end
