//
//  gameManager.cpp
//  oglApp
//
//  Created by SimonJordan on 01/04/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "gameManager.h"
//#include "globals.h"
gameManager::gameManager()
{
    glcore        = new glCore();
    engineTimer   = new timer();
    Renderer      = new renderer();
    engineFont    = new fontRenderer();
    sceneCamera   = new camera();
    //pTouch        = new touch(&touchPosition);
    systemManager = new gameSystems();

}
gameManager::~gameManager()
{
    cleanUpGameObjects();
    cleanUpGameSystems();
}

glCore* gameManager::getGLCore()
{
    return glcore;
}
timer* gameManager::getEngineTimer()
{
    return engineTimer;
}
renderer* gameManager::getRenderer()
{
    return Renderer;
}
fontRenderer* gameManager::getFontRenderer()
{
    return engineFont;
}
camera* gameManager::getSceneCamera()
{
    return sceneCamera;
}
gameSystems* gameManager::getGameSystemManager()
{
    return systemManager;
}

void gameManager::initGameSystems()
{
    GLuint vertexShader = Renderer->shader->compileShader(@"SimpleVertex", GL_VERTEX_SHADER);
    GLuint fragmentShader = Renderer->shader->compileShader(@"SimpleFragment", GL_FRAGMENT_SHADER);
    
    Renderer->shader->shaders.push_back(vertexShader);
    Renderer->shader->shaders.push_back(fragmentShader);
    
    projection = glm::mat4(1.0f);
    
    engineTimer->timerInit();
    
    glcore->createFrameBuffer();
    
    Renderer->initRendererGfx();
    
}

void gameManager::setSceneCamera(camera *theSceneCamera)
{
    sceneCamera = theSceneCamera;
}

camera* gameManager::getTheSceneCamera()
{
    return sceneCamera;
}

void gameManager::initGameObjects(float width, float height)
{
    systemManager->initialiseLevelContent(width, height);
    systemManager->initialiseGame(Renderer);

}
void gameManager::initGameData()
{
    systemManager->setTheLevelCamera(getTheSceneCamera());
    
}
void gameManager::updateGameSystems()
{

    sceneCamera->translateCameraX(0.0f);
    sceneCamera->translateCameraY(0.0f);
    sceneCamera->translateCameraZ(0.25f);

    
    engineTimer->timerUpdate();
    
    rotator += 0.1f;
}
void gameManager::updateGameObjects()
{

    systemManager->updateGame(engineTimer->deltaTime, Renderer);



}
void gameManager::updateGameData()
{
}
void gameManager::drawGameSystems(float width, float height)
{
    //This can potentially be moved into an init function and width and height put in there also, to stop the passing
    //of the data into this method every frame.
    sceneCamera->setAspectRatio(width/height);
    
    Renderer->view = sceneCamera->updateView();
    Renderer->projection = sceneCamera->updateProjection();
    
    //pTouch->checkForMovement();
    //pTouch->getOldMousePos();
    //pTouch->updateMouse(width, height, sceneCamera);
    
    //systemManager->_rootNode->translateX(-0.032083f);
    //systemManager->_rootNode->translateY(-0.050000f);
    
    systemManager->_rootNode->translateX(0);
    systemManager->_rootNode->translateY(0);
    
    
    //systemManager->_rootNode->translateX(pTouch->getWorldX());
    //systemManager->_rootNode->translateY(pTouch->getWorldY());
}
void gameManager::drawGameObjects()
{
    
    systemManager->drawGame(Renderer);
}
void gameManager::cleanUpGameSystems()
{
    glcore->deleteFramebuffer();
    safeDelete(engineTimer);
    safeDelete(glcore);
    safeDelete(engineFont);
    safeDelete(sceneCamera);
    safeDelete(Renderer);
    //safeDelete(pTouch);
    safeDelete(systemManager);
}
void gameManager::cleanUpGameObjects()
{

}
