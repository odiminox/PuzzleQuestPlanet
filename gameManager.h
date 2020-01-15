//
//  gameManager.h
//  oglApp
//
//  Created by SimonJordan on 01/04/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
// the gameManager is an abstraction away from the game logic and is responsible for handling the interaction with core systems

#ifndef oglApp_gameManager_h
#define oglApp_gameManager_h

#include "glCore.h"
#include "shaderLoader.h"
#include "timer.h"
#include "renderer.h"
#include "fontRenderer.h"
#include "camera.h"
#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include "NODEUI.h"
//#include "touch.h"


#include "memoryManager.h"
#include "gameSystems.h"
#include <vector>

class gameManager {
    
public:
    gameManager();
    ~gameManager();
    
    void initGameObjects(float width, float height);
    void initGameSystems();
    void initGameData();
    
    void updateGameObjects();
    void updateGameSystems();
    void updateGameData();
    
    void drawGameObjects();
    void drawGameSystems(float width, float height);
    
    void cleanUpGameObjects();
    void cleanUpGameSystems();
    
    void setSceneCamera(camera* theSceneCamera);
    camera* getTheSceneCamera();
    
    glCore* getGLCore();
    timer* getEngineTimer();
    renderer* getRenderer();
    fontRenderer* getFontRenderer();
    camera* getSceneCamera();
    gameSystems* getGameSystemManager();
    
private:
    glCore* glcore;
    timer* engineTimer;
    renderer* Renderer;
    fontRenderer * engineFont;
    camera* sceneCamera;
    
    gameSystems* systemManager;
    
    glm::mat4 view;
    glm::mat4 projection;
    
    
    GLint projectionMatrixLocation;
    GLint viewMatrixLocation;
    GLint modelMatrixLocation;
    
    float w;
    float h;
    
    
    float rotator;
    int cntr;

};

#endif
