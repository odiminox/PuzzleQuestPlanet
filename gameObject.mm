//
//  gameObject.cpp
//  oglApp
//
//  Created by Simon Jordan on 19/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "gameObject.h"


gameObject::gameObject()
{
    GOanimationController = new animationController(this);
    needsToAnimate = false;
}
gameObject::~gameObject()
{
    
}

CGRect gameObject::boundingBox()
{
    //Need to sort out this calculation as the division is evil
    CGRect rect = CGRectMake((GOnode->getPosX()-(worldWidth/2)), (GOnode->getPosY()-(worldHeight/2)), worldWidth, worldHeight);
    return rect;
}

void gameObject::setNeedsToAnimate(bool animSet)
{
    needsToAnimate = animSet;
}
bool gameObject::getNeedsToAnimate()
{
    return needsToAnimate;
}

float gameObject::getBlockWidth()
{
    return blockWidth;
}
float gameObject::getBlockHeight()
{
    return blockHeight;
}
void gameObject::setBlockWidth(float width)
{
    blockWidth = width;
}
void gameObject::setBlockheight(float height)
{
    blockHeight = height;
}

NODEUI* gameObject::getNode()
{
    return GOnode;
}
MESH2D* gameObject::getMeshData()
{
    return GOMeshData;
}
animationController* gameObject::getAnimCont()
{
    return GOanimationController;
}

glm::vec2 gameObject::getHomePos() const
{
    return homePos;
}

void gameObject::initMeshData()
{
    GOMeshData = new MESH2D();
}
void gameObject::initNode(MESH2D* meshData)
{
    GOnode = new NODEUI(meshData);
}

void gameObject::setNormWH(float width, float height)
{
    worldWidth = width;
    worldHeight = height;
}
float gameObject::getNormW()
{
    return worldWidth;
}
float gameObject::getNormH()
{
    return worldHeight;
}