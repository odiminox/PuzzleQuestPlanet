//
//  GLKContext.h
//  oglApp
//
//  Created by Simon Jordan on 08/12/2012.
//  Copyright (c) 2012 Simon Jordan. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface GLKContext : EAGLContext
{
    GLKVector4 clearColor;
}

@property (nonatomic, assign) GLKVector4 clearColor;

- (void)clear:(GLbitfield)mask;

@end
