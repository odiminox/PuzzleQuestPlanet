//
//  fontObject.h
//  oglApp
//
//  Created by Simon Jordan on 10/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__fontObject__
#define __oglApp__fontObject__

#include "GLKit/GLKit.h"
#include "OBJECT.h"

class fontObject : public OBJECT{
    
public:
private:
    CGImageRef m_imageRef;
    GLKTextureInfo * m_textureInfo;
    GLuint vertexBufferID;
    GLuint indexBufferID;
    GLuint textureBufferID;
    
    int m_imageWidth;
    int m_imageHeight;
    int m_imageFrameWidth;
    int m_imageFrameHeight;
    int m_cellWidth;
    int m_cellHeight;
    int m_numFrames;
    int m_startFrame;
    int m_endFrame;
};

#endif /* defined(__oglApp__fontObject__) */
