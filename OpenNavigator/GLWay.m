//
//  GLWay.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-24.
//
//

#import "GLWay.h"

#import "OpenNavNode.h"
#import "OpenNavWay.h"
#import "GLNodes.h"

@interface GLWay (hidden)
-(void) finalize;
@end

@implementation GLWay


- (id) initWithWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    if (self = [super init]) {
        _navway = way;
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
            _wayNodes[cnt * 3 + 2] = nodeVertices[currentIndex*3+2];

            _wayShortIndices[cnt*2 + 0] = cnt;
            _wayShortIndices[cnt*2 + 1] = cnt+1;


            prevIndex = currentIndex;
            ++cnt;
        }
        _count = cnt;
    }
    return self;
}


-(void) finalize
{
    // Free stuff
    free(_wayIndices);
}

- (void)render
{
    if ([_navway haveTag:@"highway"]) {
        
        glLoadIdentity();
        glTranslatef(-0.5f, 2.5f, -5.0f);
        //                glRotatef(angle, angle, angle, 0.0f);

        NSString* waytype = [_navway tagValue:@"highway"];
        NSLog(@"Waytype: %@", waytype);
        if ([waytype isEqualToString:@"residential"]) {
            NSLog(@"Waytype: residental!");
            glColor4f(1.0f, 0.0f, 1.0f, 1.0f);
            glLineWidth(2.5);
            glLineStipple(1, 0xffff);
        } else {
            NSLog(@"Waytype: other %@", waytype);
            glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
            glLineWidth(1.0);
            glLineStipple(1, 0x00ff);
        }

        //                glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
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
        glGenBuffers(1, &way1IndicesVBO);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, way1IndicesVBO);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, (_count-1) * 2 * sizeof(GLushort), tmp_indices, GL_STATIC_DRAW);

        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, way1IndicesVBO);
        glDrawElements(GL_LINES, 2*(_count-1), GL_UNSIGNED_SHORT, 0);
        glDisableClientState(GL_VERTEX_ARRAY);
        glDeleteBuffers(1, &way1IndicesVBO);
        glDeleteBuffers(1, &nodeVerticesVBO);
        
    }
}

+ (GLWay*) createFromWay: (OpenNavWay*)way usingNodes: (GLNodes*)nodes
{
    return [[GLWay alloc] initWithWay:way usingNodes:nodes];
}


@end
