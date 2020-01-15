//
//  screenElement.h
//  oglApp
//
//  Created by Simon Jordan on 19/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
//  Screen elements acts like an object type for anything that appears on the screen from a button to a box
//
#ifndef oglApp_screenElement_h
#define oglApp_screenElement_h

#include "gameObject.h"
#include <string>

//Maybe add some kind of component to the screen elements that allows us to shape their behaviour, for instance, we might want a text
//component that cannot be clicked, or a button component without text

class screenElement:public gameObject {
    
public:
    screenElement();
    ~screenElement();
    
    CGRect boundingBox();
    void setElementName(std::string name);
    std::string getElementName() const;
    
    void setIsClicked(bool click);
    bool getIsClicked();
    
private:
    std::string elementName;
    bool isClicked;
};

#endif
