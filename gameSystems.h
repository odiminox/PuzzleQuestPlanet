//
//  gameSystems.h
//  oglApp
//
//  Created by SimonJordan on 03/04/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
// this class pools together the gamestate, level logic handlers and completes the bridge between the current game session and getting
// data to and from core objects

#ifndef oglApp_gameSystems_h
#define oglApp_gameSystems_h
//#include "globals.h"
#include <iostream>
#include "memoryManager.h"
#include "states.h"
#include "NODEUI.h"
#include "MESH2D.h"
#include "bitmapFont.h"
#include "gameLevel.h"
#include "camera.h"
#include "touch.h"
#include <vector>
#include "timer.h"
#include "GUIController.h"


class gameSystems {
    
    
public:
    gameSystems();
    ~gameSystems();
    
    void initialiseLevelContent(float width, float height);
    void initialiseGame(renderer* Renderer);
    void updateGame(float delta, renderer* Renderer);
    void drawGame(renderer* Renderer);
    
    float getGameTime();
    void updateGameTime(float time);
        
    void setIsGameOver(bool isOver);
    bool getIsGameOver();
    
    void setTheLevelCamera(camera* camera);
    camera* getTheLevelCamera();
    
    
    void resetGame();
    
    class touch* _pTouch;
    
    NODEUI* _rootNode;
    
    void setSwipeRight(bool right);
    void setSwipeLeft(bool left);
    void setSwipeUp(bool up);
    void setSwipeDown(bool down);
    void setIsTouched(bool touched);
    
    bool getSwipeRight();
    bool getSwipeLeft();
    bool getSwipeUp();
    bool getSwipeDown();
    bool getIsTouched();
    
private:
    
    camera* levelCamera;
    
    states* gameState;
    
    GUIController* gameGUI;
   
    MESH2D* _rootMesh;
    
    float width;
    float height;
    
    
    timer* gameTimer;

    gameLevel* testLevel;

    float gameTime;
    
    bool gameRunning;
    bool isGameOver;
    
    bool swipeRight;
    bool swipeLeft;
    bool swipeDown;
    bool swipeUp;
    
    bool isTouched;

};

#endif
