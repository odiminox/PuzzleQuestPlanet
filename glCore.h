//
//  glCore.h
//  oglApp
//
//  Created by Simon Jordan on 03/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__glCore__
#define __oglApp__glCore__

#include "GLKit/GLKit.h"
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>


//#import <vector>

class glCore {
    
public:
    
    void createFrameBuffer();
    void deleteFramebuffer();
        
    BOOL useDepthBuffer;

private:
    
   
    GLint framebufferWidth;
    GLint framebufferHeight;
    
    GLuint defaultFramebuffer, colorRenderbuffer, depthRenderbuffer;

  
    
};

#endif /* defined(__oglApp__glCore__) */
