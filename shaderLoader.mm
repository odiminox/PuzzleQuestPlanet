//
//  shaderLoader.cpp
//  oglApp
//
//  Created by Simon Jordan on 04/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "shaderLoader.h"

GLuint shaderLoader::compileShader(NSString* shaderName, GLenum shaderType)
{
    //Get an NSString with the content of the file.
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    if(!shaderString){
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    //Pass in whether it is a fragment or pixel shader
    GLuint shaderHandle = glCreateShader(shaderType);
    
    //Give OpenGL the source code for the shader. Convert it to C-style string
    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = [shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    glCompileShader(shaderHandle);
    
    //If compilation fails, get some output to the issue.
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if(compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString* messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
    }
    
    return shaderHandle;
}

void shaderLoader::compilerShaders()
{
    //Loop through our vector of shaders and attach them
    programHandle = glCreateProgram();
    for(int i = 0; i < shaders.size(); i++)
        glAttachShader(programHandle, shaders[i]);
    
    
    glLinkProgram(programHandle);
    
    //Check to see if there were any errors with compiling the shaders
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if(linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSString* messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }

}

void shaderLoader::loadAttribute(GLuint& inAttribName, NSString* name)
{
    const char * attribName = [name UTF8String];
    inAttribName  = glGetAttribLocation(programHandle, attribName);
    attribs.push_back(inAttribName);
    glEnableVertexAttribArray(inAttribName);
}


void shaderLoader::setUniform(NSString * name, const glm::mat4 & m)
{
    const char * uniformName = [name UTF8String];
    GLint loc = glGetUniformLocation(programHandle, uniformName);
    if(loc >= 0) glUniformMatrix4fv(loc, 1, GL_FALSE, &m[0][0]);
}

void shaderLoader::setUniform(NSString* name, int val)
{
    const char * uniformName = [name UTF8String];
    GLint loc = glGetUniformLocation(programHandle, uniformName);
    if(loc>=0) glUniform1i(loc, val);
}

void shaderLoader::setUniform(NSString* name, float val)
{
    const char * uniformName = [name UTF8String];
    GLint loc = glGetUniformLocation(programHandle, uniformName);
    if(loc>=0) glUniform1f(loc, val);
}
void shaderLoader::bind()
{
    glUseProgram(programHandle);
}

void shaderLoader::unbind()
{
    glUseProgram(0);
}
