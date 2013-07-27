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

#include <sys/time.h>

@interface OpenNavOpenGLView (hidden)
-(void) initialize;
-(void) render: (float) deltaTime ;
-(void) finalize;
@end

 
@implementation OpenNavOpenGLView (hidden)

-(void) initialize
{
    NSLog(@"OpenNavOpenGLView::initialize");
    started = true;
    
	static const GLdouble corners[] = {
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
	static const GLdouble linecorners[] = {
        10,10,0,   // 0
        -10,10,0, // 1
        -10,-10,0,  // 2
        10,-10,0,  // 3
	};

    glGenBuffers(1, &lineVerticesVBO);
	glBindBuffer(GL_ARRAY_BUFFER, lineVerticesVBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(linecorners), linecorners, GL_STATIC_DRAW);

    static const GLushort lines[] = {
        0,1,
        1,2,
        2,3,
        3,0,
    };
    glGenBuffers(1, &lineIndicesVBO);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, lineIndicesVBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(lines), lines, GL_STATIC_DRAW);

//    glEnable(GL_CULL_FACE);
//	glCullFace(GL_BACK);
	//glDisable(GL_CULL_FACE);
//	glEnable(GL_DEPTH_TEST);
    //glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    _glways = [[NSMutableArray alloc] init];
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
        glVertexPointer(3, GL_DOUBLE, 3 * sizeof(GLdouble), 0);
        
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indicesVBO);
        glDrawElements(GL_TRIANGLES, 3*12, GL_UNSIGNED_SHORT, 0);
        
        glDisableClientState(GL_VERTEX_ARRAY);
    }
}
@end

@implementation OpenNavOpenGLView
@synthesize viewRect = _viewRect;


- (void) setUp
{
    NSLog(@"OpenNavOpenGLView::setUp");
    [self initialize];
    [self update];
    [self setNeedsDisplay:YES];
}
-(void) drawRect: (NSRect) bounds
{
    struct timeval start_time, end_time;
    gettimeofday(&start_time, NULL);
//    NSLog(@"OpenNavOpenGLView::drawRect");
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);


//    NSLog(@"drawRect:...");
    if(_parser != nil) { // We have a parser, lets draw all ways as a start.
    
        static GLfloat angle = 0.0f;
        angle += (1/60.0);
        glLoadIdentity();
        glTranslatef(-0.0f, -0.0f, -15.75f);
        glRotatef(-30 + sin(angle)*30, 1.0f, 0.0f, 0.0f);

        // This is a rect to show the "target" transfomration -10,-10 to 10,10
        glColor4f(0.7f, 0.7f, 0.7f, 1.0f);
        glEnableClientState(GL_VERTEX_ARRAY);

        glBindBuffer(GL_ARRAY_BUFFER, lineVerticesVBO);
        glVertexPointer(3, GL_DOUBLE, 3 * sizeof(GLdouble), 0);

        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, lineIndicesVBO);
        glDrawElements(GL_LINES, 3*4, GL_UNSIGNED_SHORT, 0);

        glDisableClientState(GL_VERTEX_ARRAY);

        // And render all ways
        for (GLWay* way in [_glways objectEnumerator]) {
            [way render];
        }
    } else {
        [self render:(1/60.0)];
    }
    //finalize();
    glFlush();

    gettimeofday(&end_time, NULL);
    double elapsed = (end_time.tv_sec - start_time.tv_sec)*1000;
    elapsed += (end_time.tv_usec-start_time.tv_usec)/1000;
    NSLog(@"RenderTime: %.0lf ms.", elapsed);
}

- (void)reshape
{
    NSLog(@"OpenNavOpenGLView::reshape");
    NSRect rect = [self bounds];
    rect.size = [self convertSize:rect.size toView:nil];
    glViewport(0, 0, NSWidth(rect), NSHeight(rect));

}

- (void) update
{
    NSLog(@"OpenNavOpenGLView::update");
    [[self openGLContext] update];
    //glViewport(0, 0, width, height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
    NSRect r = [self bounds];
    r.size = [self convertSize:r.size toView:nil];

    NSLog(@"Update: height %f / w %f = %f ", r.size.height, r.size.width, (r.size.width) / (r.size.height));
	gluPerspective(65.0f, (NSWidth(r)) / (NSHeight(r)), 1.00f, 6500.0f);
//	gluPerspective(10.0f, (r.size.width) / (r.size.height), 0.001f, 6500.0f);
	glMatrixMode(GL_MODELVIEW);
    [super update];
    NSLog(@"OpenNavOpenGLView::update--");

}

- (void) setParser: (OpenNavOsmParser*) parser
{
//    if (_parser != nil) {
//        glDeleteBuffers(1, &nodeVerticesVBO);
//        glDeleteBuffers(1, &way1IndicesVBO);
//    }
    _parser = parser;
    [self setNeedsDisplay:YES];

    NSDictionary* mjupp = [_parser nodes];
    //int x = [_parser nodes];
    nodeCorners = malloc([mjupp count] * sizeof(GLdouble));
    myNodes = [[GLNodes alloc] initWithNodes:[_parser nodes] andBounds:_viewRect ];

    for (OpenNavWay* nway in [[_parser ways] objectEnumerator]) {
        GLWay* way = [GLWay createFromWay:nway usingNodes:myNodes];
        int i = 0;
        for (i = 0; i < [_glways count]; ++i) {
            GLWay* tmpWay = _glways[i];
            if ([way priority] < [tmpWay priority]) {
                [_glways insertObject:way atIndex:i];
                break;
            }
        }
        if (i == [_glways count]) {
            [_glways addObject:way];
        }
    }

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

    [self setNeedsDisplay:YES];
}

- (void)windowDidBecomeMain:(NSNotification *)notification {
    NSLog(@"OpenNavOpenGLView::windowDidBecomeMain");
    timer = [NSTimer timerWithTimeInterval:(1/10)
                                    target:self
                                  selector:@selector(timerEvent:)
                                  userInfo:nil
                                   repeats:YES];

    NSLog(@"Got timer %@", timer);
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)timerEvent:(NSTimer *)t {
    NSLog(@"timerEvent()");
    [self setNeedsDisplay:YES];
}

@end
