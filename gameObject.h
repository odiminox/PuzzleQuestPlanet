//
//  gameObject.h
//  oglApp
//
//  Created by Simon Jordan on 19/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
//  Base class which game objects will inherit from to have a general access to animations and other base data.
//

#ifndef oglApp_gameObject_h
#define oglApp_gameObject_h

#include "animationController.h"
#include "NODEUI.h"
#include "MESH2D.h"

class animationController;

class gameObject {
    
public:
    gameObject();
    ~gameObject();
    
    NODEUI* getNode();
    MESH2D* getMeshData();
    animationController* getAnimCont();
    void initMeshData();
    void initNode(MESH2D* meshData);
    glm::vec2 getHomePos() const;
    
    void setNormWH(float width, float height);
    float getNormW();
    float getNormH();
    
    float getBlockWidth();
    float getBlockHeight();
    void setBlockWidth(float width);
    void setBlockheight(float height);
    
    CGRect boundingBox();
    
    void setNeedsToAnimate(bool animSet);
    bool getNeedsToAnimate();
    
protected:
    NODEUI* GOnode;
    MESH2D* GOMeshData;
    animationController* GOanimationController;
    
    float worldWidth;
    float worldHeight;
    
    float blockWidth;
    float blockHeight;
    
    bool needsToAnimate;
    
    glm::vec2 homePos;
};


#endif
