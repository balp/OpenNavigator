//
//  GLWayArea.h
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-25.
//
//

#import "GLWay.h"

@interface GLWayFilledArea : GLWay
{
@protected
    GLNodes* _nodes;
    NSColor* _color;
    GLuint listIndex;
}
@property NSColor* color;

- (id) initWithWay:(OpenNavWay *)way usingNodes:(GLNodes *)nodes andColor: (NSColor*)color;
- (void) setAreaProperties;
- (void) renderArea;
- (void) tesselateArea;

@end
