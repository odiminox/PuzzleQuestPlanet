//
//  GLKContext.m
//  oglApp
//
//  Created by Simon Jordan on 08/12/2012.
//  Copyright (c) 2012 Simon Jordan. All rights reserved.
//

#import "GLKContext.h"

@implementation GLKContext

- (void)setClearColor:(GLKVector4)clearColor
{
    if(self == [[self class]currentContext])
    {
        NSLog(@"Recieving context required to be current context");
    }
    }
@end
