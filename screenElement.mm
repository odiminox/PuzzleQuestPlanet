//
//  screenElement.cpp
//  oglApp
//
//  Created by Simon Jordan on 19/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "screenElement.h"

screenElement::screenElement()
{
    
}
screenElement::~screenElement()
{
    
}

CGRect screenElement::boundingBox()
{

        //Need to sort out this calculation as the division is evil
        CGRect rect = CGRectMake((GOnode->getPosX()-(worldWidth/2)), (GOnode->getPosY()-(worldHeight/2)), worldWidth, worldHeight);
        return rect;
}

void screenElement::setElementName(std::string name)
{
    elementName = name;
}
std::string screenElement::getElementName() const
{
    return elementName;
}

void screenElement::setIsClicked(bool click)
{
    isClicked = click;
}
bool screenElement::getIsClicked()
{
    return isClicked;
}