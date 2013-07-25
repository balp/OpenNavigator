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
//    GLuint nodeVerticesVBO;
//    GLuint way1IndicesVBO;
//    GLuint way1Len;
    GLuint lineVerticesVBO;
    GLuint lineIndicesVBO;
    Boolean started;
    OpenNavOsmParser* _parser;
    GLfloat* nodeCorners;
    GLNodes* myNodes;
}
- (void) setParser: (OpenNavOsmParser*) parser;
- (void) drawRect: (NSRect) bounds;
- (void) setUp;
- (void) update;
@end
