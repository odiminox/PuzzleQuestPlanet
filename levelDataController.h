//
//  levelDataController.h
//  oglApp
//
//  Created by Simon Jordan on 09/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
//  This class is responsible for retaining data that is used by the level and what the user uses to interact with the level
//  the data is generic in the sense that it ranges from normalised screen dimensions, to the user direction a user swiped in
//

#ifndef oglApp_levelDataController_h
#define oglApp_levelDataController_h

#include "blockPiece.h"
#include "gameObject.h"
#include "memoryManager.h"
#include "Texture.h"

#include <vector>

class Texture;
class blockPiece;
class gameObject;

class levelDataController {
    
public:
    levelDataController();
    ~levelDataController();
    
    void initialiseLevelData();
    
    void setTouchXY(float x, float y);
    float getTouchX();
    float getTouchY();
    
    float getBlockWidth();
    float getBlockHeight();
    
    void setPoint(CGPoint point);
    CGPoint getPoint();
    
    void setTouchHeld(bool touch);
    bool getTouchHeld();
    
    void setSystemSwipeRight(bool right);
    void setSystemSwipeLeft(bool left);
    void setSystemSwipeUp(bool up);
    void setSystemSwipeDown(bool down);
    
    bool getSwipeRight();
    bool getSwipeLeft();
    bool getSwipeUp();
    bool getSwipeDown();
    
    void setScreenWorldWidth(float width);
    void setScreenWorldHeight(float height);
    void setLevelWidth(float width);
    void setLevelHeight(float height);
    
    float getScreenWorldWidth();
    float getScreenWorldHeight();
    float getLevelWidth();
    float getLevelHeight();
    
    void setBoundsRight(float right);
    void setBoundsLeft(float left);
    void setBoundsUp(float up);
    void setBoundsDown(float down);
    
    float getBoundsRight();
    float getBoundsLeft();
    float getBoundsup();
    float getBoundsDown();
    
    void setCanDrag(bool drag);
    bool getCanDrag();
    
    void setIsTouched(bool touched);
    
    bool getIsTouched();
    
    Texture* getTextureFromCache(int texNum);
    gameObject* getRootNode();
    
    void setGridXY(int gridx, int gridy);
    
    int getGridX() const;
    int getGridY() const;
    
private:
    float levelWidth;
    float levelHeight;
    
    float levelWidthBoundsLeft;
    float levelWidthBoundsRight;
    float levelHeightBoundsUp;
    float levelHeightBoundsDown;
    
    float screenWorldWidth;
    float screenWorldHeight;
    
    float blockWidth;
    float blockHeight;
    
    bool touchHeld;
    
    bool systemSwipeRight;
    bool systemSwipeLeft;
    bool systemSwipeUp;
    bool systemSwipeDown;
    
    bool canDrag;
    
    bool isTouched;
    
    blockPiece* dirtLoader;
    blockPiece* grassLoader;
    blockPiece* plainDirtLoader;
    blockPiece* plainStoneLoader;
    blockPiece* stoneLoader;
    blockPiece* waterLoader;
    
    gameObject* rootLevelNode;
    
    int gridX;
    int gridY;
    int gridZ;
    
    //[0]plain dirt [1]plain stone [2]grass [3]dirt [4]stone
    std::vector<blockPiece*> blockTextureCache;
    
    CGPoint _point;
};


#endif
