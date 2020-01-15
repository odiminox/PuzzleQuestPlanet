//
//  MESH.h
//  oglApp
//
//  Created by SimonJordan on 22/03/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__MESH2D__
#define __oglApp__MESH2D__


#include "GLKit/GLKit.h"
//#include "../globals.h"
#include "renderer.h"
#include <vector>
#include "Bitmap.h"
#include "Texture.h"
#include <iostream>




struct Vertex2D{
    
    float position[3];
    float colour[4];
    float texCoord[2];
    
    //float _x,_y,_z;
    //Vertex(float x, float y, float z): _x(x),_y(y),_z(z){}
    //float r,g,b,a;
    //float u,v;
};
struct Index2D{
    GLuint a,b,c;
};



class MESH2D{
    
public:
    MESH2D();
    ~MESH2D();
    
    Vertex2D verts[4] = {{{-1, -1, 0},{0, 0, 0, 1}, {1.0, 1.0}},
                        {{-1, 1, 0}, {0,0, 0, 1}, {1.0, 0.0}},
                        {{1, 1, 0},{0, 0, 0, 1}, {0.0f, 0.0}},
                        {{1, -1, 0},{0, 0, 0, 1},{0.0, 1.0}}};
    
    std::vector<Vertex2D> Vertices;
    std::vector<Index2D> Indices;
    
    void setBlue(float blue);
    void setRed(float red);
    void setGreen(float green);
    void setAlpha(float alpha);
    
    void visible(bool isVisible);
    void invisible(bool isInvisible);
    
    float getRed();
    float getGreen();
    float getBlue();
    float getAlpha();
    
    GLuint loadTexture(std::string fileName);
    
    void assignAttribs(GLuint pos, GLuint col, GLuint tex);
    
    void initBuffers(renderer* Renderer);
    void bindBuffers();
    void unbindBuffers();
    void draw(renderer* Renderer);
    void updateUVs();   

public:
    
    GLuint _texture;
    
    GLuint _OtexCoordSlot;
    GLuint _OpositionSlot;
    GLuint _OcolorSlot;
	GLuint _ONormalSlot;
    
    GLuint attribute_v_coord;
    
    GLuint _OredSlot;
    GLuint _OgreenSlot;
    GLuint _OblueSlot;
    GLuint _OalphaSlot;
    
    int objectID;
    
    float textureWidth;
    float textureHeight;
    
    float min_x;
    float max_x;
    float min_y;
    float max_y;
    float min_z;
    float max_z;
    
    Texture* pTexture;
private:
    float RED;
    float GREEN;
    float BLUE;
    float ALPHA;
    unsigned int handle[4];
    GLuint vertexBufferID;
    GLuint indexBufferID;
    GLuint textureBufferID;

    GLuint vaoHandle;//global variable to hold the vertex array object.
};

#endif /* defined(__oglApp__MESH__) */
