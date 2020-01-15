//
//  engine.h
//  oglApp
//
//  Created by Simon Jordan on 03/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
/*
 _______ _______ _______   _____ _____
 |     __|_     _|     __|_|     |     |_
 |__     |_|   |_|    |  |       |       |
 |_______|_______|_______|_______|_______|
 OPENGL PUG-E rendering engine
 
 */

#ifndef __oglApp__engine__
#define __oglApp__engine__

#include "gameManager.h"

class engine {
    
public:
    void initGfx();
    void init(GLfloat width, GLfloat height);
    void update();
    void draw(GLfloat width, GLfloat height);
    float inc;
    
    gameManager* getGameManager();
    
    engine();
    ~engine();
    
private:
    gameManager* mGameManager;
};

#endif /* defined(__oglApp__engine__) */
