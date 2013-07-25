//
//  OpenNavOpenGLView.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavOsmParser.h"
#import "OpenNavOpenGLView.h"
#import "OpenNavOSMObject.h"
#import "OpenNavNode.h"
#import "OpenNavWay.h"
#import "GLNodes.h"
#import "GLWay.h"

#include <OpenGL/gl.h>
#include <OpenGL/glu.h>


@interface OpenNavOpenGLView (hidden)
-(void) initialize;
-(void) render: (float) deltaTime ;
-(void) finalize;
@end

 
@implementation OpenNavOpenGLView (hidden)


//GLuint verticesVBO;
//GLuint indicesVBO;

-(void) initialize
{
    NSLog(@"OpenNavOpenGLView::initialize");
    started = true;
    
	static const GLfloat corners[] = {
        1,1,1,   // 0
        -1,-1,1, // 1
        1,-1,1,  // 2
        -1,1,1,  // 3
        1,1,-1,  // 4
        1,-1,-1, // 5
        -1,-1,-1, //6
        -1,1,-1, // 7
	};



    glGenBuffers(1, &verticesVBO);
	glBindBuffer(GL_ARRAY_BUFFER, verticesVBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(corners), corners, GL_STATIC_DRAW);
    
    static const GLushort cube[] = {
        // Front
        0, 1, 2,
        1, 0, 3,
        
        // Left
        0, 2, 4,
        4, 2, 5,
        
        // Right
        3, 6, 1,
        3, 7, 6,
        
        // Back
        7, 4, 5,
        7, 5, 6,
        
        // Top
        7, 0, 4, 
        7, 3, 0,
        
        // Bottom
        1, 5, 2,
        1, 6, 5,
        
	};
    glGenBuffers(1, &indicesVBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesVBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(cube), cube, GL_STATIC_DRAW);

    static const GLushort lines[] = {
        0,1,
        1,2,
        2,3,
        3,4,
        5,6,
        6,7,
        7,0,
    };
    glGenBuffers(1, &lineIndicesVBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, lineIndicesVBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(lines), lines, GL_STATIC_DRAW);

    glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);
	//glDisable(GL_CULL_FACE);
	glEnable(GL_DEPTH_TEST);
    //glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    NSLog(@"OpenNavOpenGLView::initialize--");

}

-(void) finalize
{
	glDeleteBuffers(1, &verticesVBO);
	glDeleteBuffers(1, &indicesVBO);
	glDeleteBuffers(1, &lineIndicesVBO);

}

- (void)render: (float) deltaTime
{
    
    NSLog(@"OpenNavOpenGLView::render: %f, %d", deltaTime, started );
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	if(started) {
        static GLfloat angle = 0.0f;
        angle += 60.0f * deltaTime;
        
        glLoadIdentity();
        glTranslatef(0.0f, 0.0f, -5.0f);
        glRotatef(angle, angle, angle, 0.0f);
        
        glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
        glEnableClientState(GL_VERTEX_ARRAY);
        
        glBindBuffer(GL_ARRAY_BUFFER, verticesVBO);
        glVertexPointer(3, GL_FLOAT, 3 * sizeof(GLfloat), 0);
        
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesVBO);
        glDrawElements(GL_TRIANGLES, 3*12, GL_UNSIGNED_SHORT, 0);
        
        glDisableClientState(GL_VERTEX_ARRAY);
    }
}
@end

@implementation OpenNavOpenGLView


- (void) setUp
{
    NSLog(@"OpenNavOpenGLView::setUp");
    [self initialize];
    [self update];
    [self setNeedsDisplay:YES];
}
-(void) drawRect: (NSRect) bounds
{
    NSLog(@"OpenNavOpenGLView::drawRect");
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);

    
    NSLog(@"drawRect:...");
    if(_parser != nil) { // We have a parser, lets draw all ways as a start.
        GLNodes* nodes = [[GLNodes alloc] initWithNodes:[_parser nodes]];
        static GLfloat angle = 0.0f;
        angle += 60.0f * (1/60.0);
        for (OpenNavWay* nway in [[_parser ways] objectEnumerator]) {
            GLWay* way = [GLWay createFromWay:nway usingNodes:nodes];
            [way render];

        }

    } else {
        [self render:(1/60.0)];
    }
    //finalize();
    glFlush();

}

- (void) update
{
    NSLog(@"OpenNavOpenGLView::update");
    //glViewport(0, 0, width, height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
    NSRect r = [self bounds];
    NSLog(@"Update: height %f / w %f = %f ", r.size.height, r.size.width, (r.size.width) / (r.size.height));
//	gluPerspective(30.0f, (r.size.height) / (r.size.width   ), 0.001f, 6500.0f);
	gluPerspective(30.0f, (r.size.width) / (r.size.height), 0.001f, 6500.0f);
	glMatrixMode(GL_MODELVIEW);
    
    [super update];
    NSLog(@"OpenNavOpenGLView::update--");

}

- (void) setParser: (OpenNavOsmParser*) parser
{
    if (_parser != nil) {
        glDeleteBuffers(1, &nodeVerticesVBO);
        glDeleteBuffers(1, &way1IndicesVBO);
    }
    _parser = parser;
    [self setNeedsDisplay:YES];

    NSDictionary* mjupp = [_parser nodes];
    //int x = [_parser nodes];
    nodeCorners = malloc([mjupp count] * sizeof(GLfloat));
    for (NSNumber* key in mjupp) {
        NSLog(@"Key %@", key);
    }
//    GLNodes* nodes = [[GLNodes alloc] initWithNodes:[_parser nodes]];
//    GLWay* way = [[GLWay alloc] initWithWay:[_parser getWayByID: 67628281] usingNodes:nodes];
//    GLfloat* node_vert_vbo = [nodes nodeVertices];
//
//    glGenBuffers(1, &nodeVerticesVBO);
//	glBindBuffer(GL_ARRAY_BUFFER, nodeVerticesVBO);
//	glBufferData(GL_ARRAY_BUFFER, [nodes bufferSize], node_vert_vbo, GL_STATIC_DRAW);
//
//    GLushort* way_ind_vbo = [way wayIndices];
//    glGenBuffers(1, &way1IndicesVBO);
//	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, way1IndicesVBO);
//	glBufferData(GL_ELEMENT_ARRAY_BUFFER, [way bufferSize], way_ind_vbo, GL_STATIC_DRAW);
//    way1Len = [way count];


}

- (id) init
{
    if (self = [super init]) {
        _parser = nil;
        started = false;
    }
    return self;
}

static NSTimer *timer = nil;
//
- (void)windowDidResignMain:(NSNotification *)notification {
        NSLog(@"OpenNavOpenGLView::windowDidResignMain");
    [timer invalidate];
//
//    //game_deactivate();      // freeze, pause
    [self setNeedsDisplay:YES];
}
//
- (void)windowDidBecomeMain:(NSNotification *)notification {
        NSLog(@"OpenNavOpenGLView::windowDidBecomeMain");
//
//    //game_activate();
//    [self setNeedsDisplay:YES];
//
    timer = [NSTimer timerWithTimeInterval:10
                                    target:self
                                  selector:@selector(timerEvent:)
                                  userInfo:nil
                                   repeats:YES];

    NSLog(@"Got timer %@", timer);
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}
//
- (void)timerEvent:(NSTimer *)t {
    NSLog(@"timerEvent()");
    //run_game();
    [self setNeedsDisplay:YES];
}

@end
