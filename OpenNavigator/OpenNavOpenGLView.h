//
//  OpenNavOpenGLView.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

#include <OpenGL/gl.h>


@interface OpenNavOpenGLView : NSOpenGLView
{
@private
    GLuint verticesVBO;
    GLuint indicesVBO;
    Boolean started;
}
- (void) drawRect: (NSRect) bounds;
- (void) setUp;
- (void) update;
@end
