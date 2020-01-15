//
//  gameSystems.cpp
//  oglApp
//
//  Created by SimonJordan on 03/04/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "gameSystems.h"


gameSystems::gameSystems()
{
    testLevel = new gameLevel();
    gameGUI = new GUIController();
    gameTimer = new timer();
    
    swipeRight = false;
    swipeLeft = false;
    swipeDown = false;
    swipeUp = false;
    
}
gameSystems::~gameSystems()
{
    safeDelete(gameState);
    safeDelete(testLevel);
    safeDelete(gameTimer);
    safeDelete(gameGUI);
}

void gameSystems::setSwipeRight(bool right)
{
    swipeRight = right;
}
void gameSystems::setSwipeLeft(bool left)
{
    swipeLeft = left;
}
void gameSystems::setSwipeUp(bool up)
{
    swipeUp = up;
}
void gameSystems::setSwipeDown(bool down)
{
    swipeDown = down;
}

bool gameSystems::getSwipeRight()
{
    return swipeRight;
}
bool gameSystems::getSwipeLeft()
{
    return swipeLeft;
}
bool gameSystems::getSwipeUp()
{
    return swipeUp;
}
bool gameSystems::getSwipeDown()
{
    return swipeDown;
}

void gameSystems::resetGame()
{
    _rootNode->translateY(0);

    _rootNode->childNodes.clear();
    gameRunning    = false;
    isGameOver     = false;
    gameTime       = 0.0f;
    
    gameGUI->initScreens();
    gameState->setCurrentGameState(states::menuState);
}

void gameSystems::setTheLevelCamera(camera* camera)
{
    levelCamera = camera;
}

camera* gameSystems::getTheLevelCamera()
{
    return levelCamera;
}

void gameSystems::initialiseLevelContent(float width, float height)
{
    this->width = width;
    this->height = height;
    
    testLevel->getScreenWorldWidthHeight(width, height, getTheLevelCamera());

    testLevel->initialiseGameLevel();
}

void gameSystems::initialiseGame(renderer* Renderer)
{
    gameTimer->timerInit();
    
    _rootMesh = new MESH2D();
    _rootMesh->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Brown Block.png");
    _rootNode = new NODEUI(_rootMesh);
    
    _rootNode->translateX(0);
    _rootNode->translateY(0);
    _rootNode->translateZ(0);
    
    _rootNode->scaleX(.012);//Do not modify!
    _rootNode->scaleY(.014);
    _rootNode->scaleZ(1);
    
    gameState = new states();
    
    resetGame();

    _rootNode->addChildNode(testLevel->getLevelGridController()->getLevelData()->getRootNode()->getNode());
    
    for(int i = 0; i < gameGUI->getTotalGameScreens().size(); ++i){
        _rootNode->addChildNode(gameGUI->getScreenAt(i)->getScreenRootNode()->getNode());
    }
    
    _rootNode->init(Renderer);
}


void gameSystems::updateGame(float delta, renderer* Renderer)
{
    gameTimer->timerUpdate();
    
    testLevel->getLevelGridController()->getLevelData()->setIsTouched(this->isTouched);
   
    testLevel->getLevelGridController()->getLevelData()->setTouchXY(_pTouch->getWorldX(), _pTouch->getWorldY());

    testLevel->getLevelGridController()->getLevelData()->setSystemSwipeRight(getSwipeRight());
    testLevel->getLevelGridController()->getLevelData()->setSystemSwipeLeft(getSwipeLeft());
    testLevel->getLevelGridController()->getLevelData()->setSystemSwipeUp(getSwipeUp());
    testLevel->getLevelGridController()->getLevelData()->setSystemSwipeDown(getSwipeDown());
    
    _pTouch->checkForMovement();
    _pTouch->getOldMousePos();
    _pTouch->updateMouse(width, height, levelCamera);
    
    testLevel->updateLevel(gameTimer->deltaTime);
    
    if(testLevel->getLevelGridController()->getAreNodesDirty()){
        testLevel->getLevelGridController()->setAreNodesDirty(false);
        _rootNode->init(Renderer);
        testLevel->getLevelGridController()->sortBlocks();
    }
    
    _rootNode->update(delta);
    
    setSwipeRight(false);
    setSwipeLeft(false);
    setSwipeUp(false);
    setSwipeDown(false);    
}


void gameSystems::drawGame(renderer* Renderer)
{
    Renderer->shader->bind();
    _rootNode->draw(Renderer);
    Renderer->shader->unbind();
}



void gameSystems::updateGameTime(float time)
{
    gameTime = time;
}



void gameSystems::setIsTouched(bool touched)
{
    this->isTouched = touched;
}












