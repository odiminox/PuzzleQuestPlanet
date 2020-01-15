//
//  gameScreen.cpp
//  oglApp
//
//  Created by Simon Jordan on 19/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "gameScreen.h"


gameScreen::gameScreen()
{
    isCurrentScreen = false;
    screenRootNode = new gameObject();
}
gameScreen::~gameScreen()
{
    
}

gameObject* gameScreen::getScreenRootNode()
{
    return screenRootNode;
}

void gameScreen::addElementToScreen(screenElement* element)
{
    screenElements.push_back(element);
}
std::vector<screenElement*> gameScreen::getElementsFromScreen()
{
    return screenElements;
}
screenElement* gameScreen::getElementByName(std::string name)
{
    for(int i = 0; i < screenElements.size(); ++i){
        if(screenElements[i]->getElementName() == name){
            return screenElements[i];
        }
    }
}

void gameScreen::setIsCurrentScreen(bool current)
{
    isCurrentScreen = current;
}
bool gameScreen::getIsCurrentScreen()
{
    return isCurrentScreen;
}