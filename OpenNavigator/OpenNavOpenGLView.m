//
//  OpenNavOpenGLView.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2012-07-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OpenNavOpenGLView.h"
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
    
    glEnable(GL_CULL_FACE);
	glCullFace(GL_BACK);
	//glDisable(GL_CULL_FACE);
	glEnable(GL_DEPTH_TEST);
    //glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
}

-(void) finalize
{
	glDeleteBuffers(1, &verticesVBO);
	glDeleteBuffers(1, &indicesVBO);
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

static void drawAnObject ()
{
    glColor3f(1.0f, 0.85f, 0.35f);
    glBegin(GL_TRIANGLES);
    {
        glVertex3f(  0.0,  0.6, 0.0);
        glVertex3f( -0.2, -0.3, 0.0);
        glVertex3f(  0.2, -0.3 ,0.0);
    }
    glEnd();
}
- (void) setUp
{
    [self initialize];
}
-(void) drawRect: (NSRect) bounds
{
    NSLog(@"OpenNavOpenGLView::drawRect");
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    drawAnObject();
    //initialize();
    NSLog(@"drawRect:...");
    [self render:0.1];
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
	gluPerspective(65.0f, (r.size.width) / (r.size.height), 1.0f, 650.0f);
	glMatrixMode(GL_MODELVIEW);
    
	//windowWidth = static_cast<unsigned int>(width);
	//windowHeight = static_cast<unsigned int>(height);
    [super update];
}

@end
