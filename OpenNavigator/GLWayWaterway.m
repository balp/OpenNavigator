//
//  GLWayWaterway.m
//  OpenNavigator
//
//  Created by Anders Arnholm on 2013-07-26.
//
//

#import "GLWayWaterway.h"

#import "OpenNavNode.h"
#import "OpenNavWay.h"
#import "GLNodes.h"

@implementation GLWayWaterway

- (void) setLineProperties
{
    NSString* watertype = [_navway tagValue:@"waterway"];
    if ([watertype isEqualToString:@"stream"]) {
        if ([_navway haveTag:@"tunnel"]) {
            glColor4f(0.1f, 0.1f, 0.6f, 1.0f);
            glLineWidth(1.5);
        } else {
            glColor4f(0.1f, 0.1f, 0.7f, 1.0f);
            glLineWidth(2.0);
        }
    } else {
        NSLog(@"Wateray: other %@", watertype);

        glColor4f(0.0f, 0.0f, 1.0f, 1.0f);
        glLineWidth(6.0);
        glLineStipple(1, 0x00ff);
    }
}


@end
