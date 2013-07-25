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
        _bufferSize = [[way nodes] count] * sizeof(GLushort) * 2;
        _wayIndices = malloc(_bufferSize);
        _wayShortIndices = malloc(_bufferSize);
        _wayNodes = malloc([[way nodes] count] * sizeof(GLfloat) * 3);
        int cnt = 0;
        GLushort prevIndex = 0;
        GLushort currentIndex = 0;
        GLfloat* nodeVertices = [nodes nodeVertices];
        for (NSNumber* node in [way nodes]) {
            currentIndex = [nodes indexOfNodeWithId:node];
            if (cnt > 0) {
                _wayIndices[(cnt-1)*2 + 0] = prevIndex;
                _wayIndices[(cnt-1)*2 + 1] = currentIndex;
            }
            _wayNodes[cnt * 3 + 0] = nodeVertices[currentIndex*3+0];
            _wayNodes[cnt * 3 + 1] = nodeVertices[currentIndex*3+1];
            _wayNodes[cnt * 3 + 2] = nodeVertices[currentIndex*3+2]-0.01;

            if(cnt== 0) {
                _wayShortIndices[0]= 0;
            } else if(cnt % 2) {
                _wayShortIndices[cnt]= (cnt/2)+1;
            } else {
                _wayShortIndices[cnt] = [[way nodes] count]-(cnt/2);
            }


            prevIndex = currentIndex;
            ++cnt;
        }
//        GLUtesselator* tobj = gluNewTess();
//        gluTessCallback(tobj, GLU_TESS_VERTEX, <#GLvoid (*CallBackFunc)()#>)
//        
        _count = cnt;
    }
    return self;
}

-(void) finalize
{
    // Free stuff
    free(_wayIndices);
    free(_wayShortIndices);
    free(_wayNodes);
}


- (void)render
{
    [self setAreaProperties];
    [self renderArea];
}

- (void) renderArea
{
    glEnableClientState(GL_VERTEX_ARRAY);

    GLfloat* tmp_nodes = _wayNodes;
    GLuint nodeVerticesVBO;
    glGenBuffers(1, &nodeVerticesVBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, nodeVerticesVBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, _count * 3 * sizeof(GLfloat), tmp_nodes, GL_STATIC_DRAW);


    glBindBuffer(GL_ARRAY_BUFFER, nodeVerticesVBO);
    glVertexPointer(3, GL_FLOAT, 3 * sizeof(GLfloat), 0);

    GLuint way1IndicesVBO;
    GLushort* tmp_indices = _wayShortIndices;
    for (int i = 0; i < _count; ++i) {
        NSLog(@"_waySortIndices[%d] = %d ( %f, %f, %f)", i,
              _wayShortIndices[i],
              _wayNodes[i*3+0], _wayNodes[i*3+1], _wayNodes[i*3+2]
              );
    }
    glGenBuffers(1, &way1IndicesVBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, way1IndicesVBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, (_count) * sizeof(GLushort), tmp_indices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, way1IndicesVBO);
    glDrawElements(GL_TRIANGLE_STRIP, (_count), GL_UNSIGNED_SHORT, 0);
    glDisableClientState(GL_VERTEX_ARRAY);
    glDeleteBuffers(1, &way1IndicesVBO);
    glDeleteBuffers(1, &nodeVerticesVBO);
    
}

@end
