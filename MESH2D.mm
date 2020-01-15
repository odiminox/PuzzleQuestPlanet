//
//  MESH.cpp
//  oglApp
//
//  Created by SimonJordan on 22/03/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "MESH2D.h"



static const GLubyte testIndices2D[] =
{
	1,0,2,3
};

MESH2D::MESH2D():pTexture(NULL)
{
    RED   = 1;
    GREEN = 1;
    BLUE  = 1;
    ALPHA = 1;
    
  
}
MESH2D::~MESH2D()
{
    safeDelete(pTexture);
}


GLuint MESH2D::loadTexture(std::string fileName)
{
    Bitmap bmp = Bitmap::bitmapFromFile(fileName);
    bmp.flipVertically();
    pTexture = new Texture(bmp);
    
    return pTexture->_object;
}

void MESH2D::draw(renderer* Renderer)
{
    bindBuffers();

    
    Renderer->shader->setUniform(@"red",   getRed());
    Renderer->shader->setUniform(@"green", getGreen());
    Renderer->shader->setUniform(@"blue",  getBlue());
    Renderer->shader->setUniform(@"alpha", getAlpha());

	//Renderer->shader->setUniform(@"Kd", 0.9f, 0.5f, 0.3f);
	//Renderer->shader->setUniform(@"Ld", 1.0f, 1.0f, 1.0f);
	//Renderer->pShader->setUniform(@"LightPosition", Renderer->view * glm::vec4(5.0f,4.0f,15.0f,1.0f) );
    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, pTexture->_object);
    
    Renderer->shader->setUniform(@"Texture", 0);//Apply the uniform for this instance
    
	//glBindVertexArray(vaoHandle);
    glDrawElements(GL_TRIANGLE_STRIP, sizeof(testIndices2D)/sizeof(testIndices2D[0]), GL_UNSIGNED_BYTE, 0);
    
    unbindBuffers();
}

void MESH2D::bindBuffers()
{
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
}

void MESH2D::unbindBuffers()
{
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

void MESH2D::initBuffers(renderer* Renderer)
{
	Renderer->shader->loadAttribute(_OpositionSlot,@"Position");
	Renderer->shader->loadAttribute(_OcolorSlot,   @"SourceColor");
	Renderer->shader->loadAttribute(_OtexCoordSlot,@"TexCoordIn");

    glGenBuffers(1, &vertexBufferID);
	glGenBuffers(1, &indexBufferID);

	//glGenVertexArraysOES( 1, &vaoHandle );
	//glBindVertexArrayOES(vaoHandle);

    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verts), verts, GL_STATIC_DRAW);
	glVertexAttribPointer(_OpositionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex2D) , 0);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(testIndices2D), testIndices2D, GL_STATIC_DRAW);


	glEnableVertexAttribArray(_OpositionSlot); // Vertex Position
	glEnableVertexAttribArray(_OcolorSlot);    // Vertex Colour
	glEnableVertexAttribArray(_OtexCoordSlot); // Vertex Texture

	glVertexAttribPointer((GLuint)_OpositionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex2D), 0);
	glVertexAttribPointer((GLuint)_OcolorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex2D) , (GLvoid*)(sizeof(GL_FLOAT) * 3));
	glVertexAttribPointer((GLuint)_OtexCoordSlot, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex2D) , (GLvoid*)(sizeof(GL_FLOAT) * 7));
}



void MESH2D::assignAttribs(GLuint pos, GLuint col, GLuint tex)
{
    _OpositionSlot = pos;
    _OcolorSlot    = col;
    _OtexCoordSlot = tex;
}

void MESH2D::visible(bool isVisible)
{
    if(isVisible)
        setAlpha(1.0f);
}

void MESH2D::invisible(bool isInvisible)
{
    if(isInvisible)
        setAlpha(0.0f);
}
void MESH2D::setRed(float red){RED = red;}
void MESH2D::setGreen(float green){GREEN = green;}
void MESH2D::setBlue(float blue){BLUE = blue;}
void MESH2D::setAlpha(float alpha){ALPHA = alpha;}
float MESH2D::getRed(){return RED;}
float MESH2D::getGreen(){return GREEN;}
float MESH2D::getBlue(){return BLUE;}
float MESH2D::getAlpha(){return ALPHA;}




