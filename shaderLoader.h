//
//  shaderLoader.h
//  oglApp
//
//  Created by Simon Jordan on 04/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__shaderLoader__
#define __oglApp__shaderLoader__

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#include "glm/glm.hpp"
#import <vector>

class shaderLoader {
    
public:
    GLuint compileShader(NSString* shaderName, GLenum shaderType);
    void compilerShaders();
    void loadAttribute(GLuint& inAttribName, NSString* name);
    void setUniform(NSString* name, const glm::mat4 & m);
    void setUniform(NSString* name, int val);
    void setUniform(NSString* name, float val);
    void bind();
    void unbind();
    
    std::vector<GLuint> shaders;
    std::vector<GLuint> attribs;
    std::vector<GLuint> uniforms;
    
    GLuint programHandle;

private:
    //GLuint _texCoordSlot;
    //GLuint _textureUniform;
    //GLuint _positionSlot;
    //GLuint _colorSlot;
    //GLuint _projectionUniform;
    //GLuint _modelViewUniform;
    
  
  
};

#endif /* defined(__oglApp__shaderLoader__) */
