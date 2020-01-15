//
//  glCore.cpp
//  oglApp
//
//  Created by Simon Jordan on 03/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "glCore.h"


void glCore::createFrameBuffer()
{
    //glGenBuffers(1, &defaultFramebuffer);
    //glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
    
    glGenRenderbuffers(1, &colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_RGBA8_OES, framebufferWidth, framebufferHeight);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
    
    glViewport(0, 0, framebufferWidth, framebufferHeight);
    useDepthBuffer = TRUE;
    if(useDepthBuffer)
    {
        glGenRenderbuffers(1, &depthRenderbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, framebufferWidth, framebufferHeight);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderbuffer);
    }
  
}


void glCore::deleteFramebuffer()
{
    if(colorRenderbuffer)
    {
        glDeleteFramebuffers(1, &colorRenderbuffer);
        colorRenderbuffer = 0;
    }
    if(depthRenderbuffer)
    {
        glDeleteFramebuffers(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}

