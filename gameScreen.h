//
//  gameScreen.h
//  oglApp
//
//  Created by Simon Jordan on 19/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
//  Game screen contains and collects the data and interaction with screen elements and is responsible for a shift in state
//  depending on the users interaction with the screen elements
//

#ifndef oglApp_gameScreen_h
#define oglApp_gameScreen_h

#include "screenElement.h"
#include "gameObject.h"
#include <vector>
class gameScreen {
    
public:
    gameScreen();
    ~gameScreen();
    
    void addElementToScreen(screenElement* element);
    std::vector<screenElement*> getElementsFromScreen();
    screenElement* getElementByName(std::string name);
    
    gameObject* getScreenRootNode();//remember to get and init the root node first
    
    void setIsCurrentScreen(bool current);
    bool getIsCurrentScreen();
    
private:
    std::vector<screenElement*> screenElements;
    gameObject* screenRootNode;//This is the root which all screen elements will be a child of, usually the background or static part of the scene
    bool isCurrentScreen;
};

#endif
