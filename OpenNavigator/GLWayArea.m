//
//  GLWayArea.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-25.
//
//

#import "GLWayArea.h"
#import "GLWay.h"
#import "GLWayHighway.h"
#import "GLWayCoastline.h"
#import "GLWayPier.h"

#import "OpenNavNode.h"
#import "OpenNavWay.h"
#import "GLNodes.h"

#include <GLUT/GLUT.h>


@interface GLWayArea (hidden)
-(void) finalize;
@end

@implementation GLWayArea

- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    if (self = [super initWithWay:way usingNodes:nodes]) {
        _nodes = nodes;
//        _bufferSize = [[way nodes] count] * sizeof(GLushort) * 2;
//        _wayIndices = malloc(_bufferSize);
//        _wayShortIndices = malloc(_bufferSize);
//        _wayNodes = malloc([[way nodes] count] * sizeof(GLfloat) * 3);
//        int cnt = 0;
//        GLushort prevIndex = 0;
//        GLushort currentIndex = 0;
//            
//            if (cnt > 0) {
//                _wayIndices[(cnt-1)*2 + 0] = prevIndex;
//                _wayIndices[(cnt-1)*2 + 1] = currentIndex;
//            }
//            _wayNodes[cnt * 3 + 0] = nodeVertices[currentIndex*3+0];
//            _wayNodes[cnt * 3 + 1] = nodeVertices[currentIndex*3+1];
//            _wayNodes[cnt * 3 + 2] = nodeVertices[currentIndex*3+2]-0.01;

//            _wayShortIndices[cnt]= cnt;


//            prevIndex = currentIndex;
//            ++cnt;
//        GLUtesselator* tobj = gluNewTess();
//        gluTessCallback(tobj, GLU_TESS_VERTEX, <#GLvoid (*CallBackFunc)()#>)
//        
//        _count = cnt;
    }
    return self;
}

-(void) finalize
{
    // Free stuff
//    free(_wayIndices);
//    free(_wayShortIndices);
//    free(_wayNodes);
}


- (void)render
{
    [self setAreaProperties];
    [self renderArea];
}

- (void) setAreaProperties
{
    glColor4f(0.8f, 0.5f, .2f, 0.5f);
    glLineWidth(1.5);

}
static void beginCallback(GLenum mode)
{
    NSLog(@"beginCallback(%d)", mode);
    glBegin(mode);

}
static void endCallback()
{
    NSLog(@"endCallback");
    glEnd();
}
static void vertexCallback(GLvoid *vertex)
{
    const GLdouble* ptr = vertex;
    NSLog(@"vertexCallback() (%lf,%lf,%lf)", ptr[0], ptr[1], ptr[2]);
    glVertex3dv(vertex);
}

static void myCombine( GLdouble coords[3],
                      GLdouble *vertex_data[4],
                      GLfloat weight[4],
                      GLdouble **dataOut )
{
    GLdouble *vertex = malloc(6 * sizeof(GLdouble));
    NSLog(@"myCombine()  (%lf, %lf, %lf)",
          vertex[0],
          vertex[1],
          vertex[2]);

    vertex[0] = coords[0];
    vertex[1] = coords[1];
    vertex[2] = coords[2];
    NSLog(@"weight[0] %f", weight[0]);
    NSLog(@"weight[1] %f", weight[1]);
    NSLog(@"weight[2] %f", weight[2]);
    NSLog(@"weight[3] %f", weight[3]);
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
        NSLog(@"gluTessVertex() %d  (%lf, %lf, %lf)", currentIndex, 
              nodeVertices[currentIndex*3+0],
              nodeVertices[currentIndex*3+1],
              nodeVertices[currentIndex*3+2]);
        gluTessVertex(tobj, &(nodeVertices[currentIndex*3]),
                      &(nodeVertices[currentIndex*3]));
    }
    gluTessEndContour(tobj);
    gluTessEndPolygon(tobj);
    gluDeleteTess(tobj);
#endif
}

@end
