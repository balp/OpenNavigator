//
//  GLWayHighway.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-25.
//
//

#import "GLWayHighway.h"

#import "OpenNavNode.h"
#import "OpenNavWay.h"
#import "GLNodes.h"

@implementation GLWayHighway

- (void) setLineProperties
{
    NSString* waytype = [_navway tagValue:@"highway"];
    if ([waytype isEqualToString:@"tertiary"]) {
        glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
        glLineWidth(3.5);
        glLineStipple(1, 0xffff);
    } else if ([waytype isEqualToString:@"residential"]) {
        glColor4f(1.0f, 0.3f, 0.3f, 1.0f);
        glLineWidth(2.0);
        glLineStipple(3, 0x000f);
    } else if ([waytype isEqualToString:@"unclassified"]) {
        glColor4f(0.9f, 0.5f, 0.3f, 1.0f);
        glLineWidth(1.0);
        glLineStipple(3, 0x000f);
    } else if ([waytype isEqualToString:@"path"]) {
        glColor4f(0.9f, 0.9f, 0.30f, 1.0f);
        glLineWidth(1.0);
        glLineStipple(3, 0x000f);
    } else if ([waytype isEqualToString:@"footway"]) {
        glColor4f(0.9f, 0.4f, 0.30f, 1.0f);
        glLineWidth(1.0);
        glLineStipple(3, 0x000f);
    } else {
        NSLog(@"Waytype: other %@", waytype);

        glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
        glLineWidth(6.0);
        glLineStipple(1, 0x00ff);
    }
}
@end
