//
//  levelDataController.cpp
//  oglApp
//
//  Created by Simon Jordan on 09/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "levelDataController.h"

levelDataController::levelDataController()
{
    blockWidth = 0.024;
    blockHeight = 0.022;
    canDrag = false;
}
levelDataController::~levelDataController()
{
     safeDelete(dirtLoader);
     safeDelete(plainDirtLoader);
     safeDelete(plainStoneLoader);
     safeDelete(grassLoader);
     safeDelete(waterLoader);
     safeDelete(stoneLoader);
}

void levelDataController::initialiseLevelData()
{
    plainDirtLoader = new blockPiece();
    dirtLoader = new blockPiece();
    grassLoader = new blockPiece();
    plainStoneLoader = new blockPiece();
    stoneLoader = new blockPiece();
    waterLoader = new blockPiece();
    
    plainDirtLoader->initMeshData();
    dirtLoader->initMeshData();
    grassLoader->initMeshData();
    plainStoneLoader->initMeshData();
    stoneLoader->initMeshData();
    waterLoader->initMeshData();

    plainDirtLoader->initNode(plainDirtLoader->getMeshData());
    dirtLoader->initNode(dirtLoader->getMeshData());
    grassLoader->initNode(grassLoader->getMeshData());
    stoneLoader->initNode(stoneLoader->getMeshData());
    waterLoader->initNode(waterLoader->getMeshData());
    plainStoneLoader->initNode(plainStoneLoader->getMeshData());
    
    plainDirtLoader->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Brown Block.png");
    dirtLoader->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Dirt Block.png");
    grassLoader->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Grass Block.png");
    stoneLoader->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Stone Block.png");
    waterLoader->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Water Block.png");
    plainStoneLoader->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Plain Block.png");
    
    rootLevelNode = new gameObject();
    
    //[0]plain dirt [1]plain stone [2]grass [3]dirt [4]stone [5]water
    blockTextureCache.push_back(plainDirtLoader);
    blockTextureCache.push_back(plainStoneLoader);
    blockTextureCache.push_back(grassLoader);
    blockTextureCache.push_back(dirtLoader);
    blockTextureCache.push_back(stoneLoader);
    blockTextureCache.push_back(waterLoader);
}

gameObject* levelDataController::getRootNode()
{
    return rootLevelNode;
}

int levelDataController::getGridX() const
{
    return gridX;
}
int levelDataController::getGridY() const
{
    return gridY;
}

void levelDataController::setGridXY(int gridx, int gridy)
{
    gridX = gridx;
    gridY = gridy;
}

void levelDataController::setIsTouched(bool touched)
{
    isTouched = touched;
}
bool levelDataController::getIsTouched()
{
    return isTouched;
}

void levelDataController::setTouchXY(float x, float y)
{
    _point.x = x;
    _point.y = y;
}

float levelDataController::getBlockWidth()
{
    return blockWidth;
}
float levelDataController::getBlockHeight()
{
    return blockHeight;
}

float levelDataController::getTouchX()
{
    return _point.x;
}
float levelDataController::getTouchY()
{
    return _point.y;
}

void levelDataController::setPoint(CGPoint point)
{
    _point = point;
}

CGPoint levelDataController::getPoint()
{
    return _point;
}

Texture* levelDataController::getTextureFromCache(int texNum)
{
    return blockTextureCache[texNum]->getMeshData()->pTexture;
}

void levelDataController::setTouchHeld(bool touch)
{
    touchHeld = touch;
}
bool levelDataController::getTouchHeld()
{
    return touchHeld;
}

void levelDataController::setSystemSwipeRight(bool right)
{
    systemSwipeRight = right;
}
void levelDataController::setSystemSwipeLeft(bool left)
{
    systemSwipeLeft = left;
}
void levelDataController::setSystemSwipeUp(bool up)
{
    systemSwipeUp = up;
}
void levelDataController::setSystemSwipeDown(bool down)
{
    systemSwipeDown = down;
}

bool levelDataController::getSwipeRight()
{
    return systemSwipeRight;
}
bool levelDataController::getSwipeLeft()
{
    return systemSwipeLeft;
}
bool levelDataController::getSwipeUp()
{
    return systemSwipeUp;
}
bool levelDataController::getSwipeDown()
{
    return systemSwipeDown;
}

void levelDataController::setScreenWorldWidth(float width)
{
    screenWorldWidth = width;
}
void levelDataController::setScreenWorldHeight(float height)
{
    screenWorldHeight = height;
}
void levelDataController::setLevelWidth(float width)
{
    levelWidth = width;
}
void levelDataController::setLevelHeight(float height)
{
    levelHeight = height;
}

float levelDataController::getScreenWorldWidth()
{
    return screenWorldWidth;
}
float levelDataController::getScreenWorldHeight()
{
    return screenWorldHeight;
}
float levelDataController::getLevelWidth()
{
    return levelWidth;
}
float levelDataController::getLevelHeight()
{
     return levelHeight;
}

void levelDataController::setBoundsRight(float right)
{
    levelWidthBoundsRight = right;
}
void levelDataController::setBoundsLeft(float left)
{
    levelWidthBoundsLeft = left;
}
void levelDataController::setBoundsUp(float up)
{
    levelHeightBoundsUp = up;
}
void levelDataController::setBoundsDown(float down)
{
    levelHeightBoundsDown = down;
}

float levelDataController::getBoundsRight()
{
    return levelWidthBoundsRight;
}
float levelDataController::getBoundsLeft()
{
    return levelWidthBoundsLeft;
}
float levelDataController::getBoundsup()
{
    return levelHeightBoundsUp;
}
float levelDataController::getBoundsDown()
{
    return levelHeightBoundsDown;
}

void levelDataController::setCanDrag(bool drag)
{
    canDrag = drag;
}
bool levelDataController::getCanDrag()
{
    return canDrag;
}
