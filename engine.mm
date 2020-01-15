//
//  engine.cpp
//  oglApp
//
//  Created by Simon Jordan on 03/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//


#include "engine.h"
engine::engine()
{
    mGameManager = new gameManager();
}
engine::~engine()
{
    safeDelete(mGameManager);
}

void engine::initGfx()
{
    glClearColor(0.5f, 0.5f, 0.9f, 1.0f);
    
    mGameManager->initGameData();
    mGameManager->initGameSystems();
}

void engine::init(GLfloat width, GLfloat height)
{
    initGfx();
    mGameManager->initGameObjects(width, height);
    
}
gameManager* engine::getGameManager()
{
    return mGameManager;
}
void engine::update()
{
    mGameManager->updateGameSystems();
    mGameManager->updateGameData();
    mGameManager->updateGameObjects();
}

void engine::draw(GLfloat width, GLfloat height)
{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    //glDepthFunc(GL_ALWAYS);
    glEnable(GL_DEPTH_TEST);
    
    glEnable(GL_BLEND);
    
    mGameManager->drawGameSystems(width, height);
    mGameManager->drawGameObjects();
    
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}

