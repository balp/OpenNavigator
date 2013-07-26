//
//  GLWayArea.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-25.
//
//

#import "GLWayFilledArea.h"
#import "GLWay.h"
#import "GLWayHighway.h"
#import "GLWayCoastline.h"
#import "GLWayPier.h"

#import "OpenNavNode.h"
#import "OpenNavWay.h"
#import "GLNodes.h"

#include <GLUT/GLUT.h>


@interface GLWayFilledArea (hidden)
-(void) finalize;
@end

@implementation GLWayFilledArea
@synthesize color = _color;

- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes andColor:(NSColor *)color
{
    if (self = [super initWithWay:way usingNodes:nodes]) {
        _nodes = nodes;
        _color = color;
        
        // Tesselation should be done and saved here.
    }
    return self;
}
- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    if (self = [super initWithWay:way usingNodes:nodes]) {
        _nodes = nodes;
        _color = [NSColor colorWithCalibratedRed:1.0f green:0.0f blue:0.0f alpha:1.0f];

        // Tesselation should be done and saved here.
    }
    return self;
}


-(void) finalize
{

}


- (void)render
{
    [self setAreaProperties];
    [self renderArea];
}

- (void) setAreaProperties
{
    glColor4f([_color redComponent], [_color greenComponent], [_color blueComponent ], [_color alphaComponent]);
}
static void beginCallback(GLenum mode)
{
//    NSLog(@"beginCallback(%d)", mode);
    glBegin(mode);

}
static void endCallback()
{
//    NSLog(@"endCallback");
    glEnd();
}
static void vertexCallback(GLvoid *vertex)
{
//    const GLdouble* ptr = vertex;
//    NSLog(@"vertexCallback() (%lf,%lf,%lf)", ptr[0], ptr[1], ptr[2]);
    glVertex3dv(vertex);
}

static void myCombine( GLdouble coords[3],
                      GLdouble *vertex_data[4],
                      GLfloat weight[4],
                      GLdouble **dataOut )
{
    GLdouble *vertex = malloc(6 * sizeof(GLdouble));
//    NSLog(@"myCombine()  (%lf, %lf, %lf)",
//          coords[0],
//          coords[1],
//          coords[2]);

    vertex[0] = coords[0];
    vertex[1] = coords[1];
    vertex[2] = coords[2];
//    NSLog(@"weight[0] %f", weight[0]);
//    NSLog(@"weight[1] %f", weight[1]);
//    NSLog(@"weight[2] %f", weight[2]);
//    NSLog(@"weight[3] %f", weight[3]);
//    for(int i=3 ; i < 7; i++)
//    {
//        GLdouble a = weight[0] * vertex_data[0][i];
//        GLdouble b = weight[1] * vertex_data[1][i];
//        GLdouble c = weight[2] * vertex_data[2][i];
//        GLdouble d = weight[3] * vertex_data[3][i];
//        vertex[i] = a + b + c + d;
//    }
    *dataOut = vertex;
}

- (void) renderArea
{
#if 1
    GLdouble* nodeVertices = [_nodes nodeVertices];
    if (!nodeVertices) {
        return;
    }
    GLUtesselator* tobj = gluNewTess();

    gluTessCallback(tobj, GLU_TESS_BEGIN, beginCallback);
    gluTessCallback(tobj, GLU_TESS_VERTEX, vertexCallback);
    gluTessCallback(tobj, GLU_TESS_END, endCallback);
    gluTessCallback(tobj, GLU_TESS_COMBINE, myCombine);
    
    gluTessBeginPolygon(tobj, NULL);
    
    gluTessBeginContour(tobj);
    for (NSNumber* node in [_navway nodes]) {
        GLushort currentIndex = [_nodes indexOfNodeWithId:node];
//        NSLog(@"gluTessVertex() %d  (%lf, %lf, %lf)", currentIndex, 
//              nodeVertices[currentIndex*3+0],
//              nodeVertices[currentIndex*3+1],
//              nodeVertices[currentIndex*3+2]);
        gluTessVertex(tobj, &(nodeVertices[currentIndex*3]),
                      &(nodeVertices[currentIndex*3]));
    }
    gluTessEndContour(tobj);
    gluTessEndPolygon(tobj);
    gluDeleteTess(tobj);
#endif
}

@end
