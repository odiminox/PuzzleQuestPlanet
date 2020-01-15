//
//  NODE.h
//  oglApp
//
//  Created by SimonJordan on 22/03/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//


//TESTEST

#ifndef __oglApp__NODEUI__
#define __oglApp__NODEUI__

//#include "../globals.h"
#include <iostream>
//#include <GL/glew.h>


#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "memoryManager.h"
#include "MESH2D.h"
#include <vector>
#include "renderer.h"

class NODEUI;
class MESH2D;

class NODEUI {
    
    
public:
	NODEUI(MESH2D* nodeMesh2D);
    virtual ~NODEUI();
    
    void rotateX(GLfloat angle);
    void rotateY(GLfloat angle);
    void rotateZ(GLfloat angle);
    
    void scaleX(GLfloat amount);
    void scaleY(GLfloat amount);
    void scaleZ(GLfloat amount);
    
    void offsetScaleX(GLfloat amount);
    void offsetScaleY(GLfloat amount);
    void offsetScaleZ(GLfloat amount);
    
    void translateX(GLfloat amount);
    void translateY(GLfloat amount);
    void translateZ(GLfloat amount);
    
    void offsetX(GLfloat amount);
    void offsetY(GLfloat amount);
    void offsetZ(GLfloat amount);
    
    void offsetToXPoint(GLfloat x, GLfloat speed);
    void offsetToYPoint(GLfloat y, GLfloat speed);
    void offsetToZPoint(GLfloat z, GLfloat speed);

    
    
    float getPosX();
    float getPosY();
    float getPosZ();
    float getScaleX();
    float getScaleY();
    float getScaleZ();
    float getRotX();
    float getRotY();
    float getRotZ();
    
    void setRenderOrderID(float ID);
    float getRenderOrderID();
    
    void setBlockRenderORderID(float ID);
    float getBlockRenderOrderID();
    
    glm::mat4 getScale();
    glm::mat4 getTranslate();
    glm::mat4 getRotation();
    
    MESH2D* getMesh();
    
    virtual void init(renderer* Renderer);
    virtual void update(float delta);
    virtual void draw(renderer* Renderer);
    
    void addChildNode(NODEUI* childNode);
    void removeChild(NODEUI* childNode);
    void setParentNode(NODEUI* parent);
    void addMesh(MESH2D* nodeMesh);
    
    std::vector<NODEUI*>::iterator getChildIteratorStart() { return childNodes.begin() ;}
    std::vector<NODEUI*>::iterator getChildIteratorEnd()   { return childNodes.end()   ;}
    
    void drawBoundingBox(MESH2D* mesh);
    
    //Need to create appropriate getters etc. to hide data, keep public for now, for testing
public:
    glm::mat4 scaleMatrix;
    glm::mat4 rotateMatrix;
    glm::mat4 translateMatrix;
    glm::mat4 pointRotation;
    
    glm::vec3 positon;
    glm::vec3 scale;
    
    glm::mat4 model;
    glm::mat4 mv;

    glm::mat4 worldTranslate;
    glm::mat4 worldRotate;
    glm::mat4 worldScale;
    
    glm::vec3 size;
    glm::vec3 center;
    glm::mat4 transform;
    glm::mat4 boxModel;
    glm::mat4 boxModelView;
    
    float rotX;
    float rotY;
    float rotZ;
    
    int _id;
    int _parentID;
    
    float _renderOrderID;
    float _blockrenderOrderID;
    
    bool isNodeDirty;
    bool renderMe;
    
public:
    std::vector<NODEUI*> childNodes;
    NODEUI* parentNode;
	MESH2D* meshNode2D;
};

#endif /* defined(__oglApp__NODE__) */
