//
//  GUIController.h
//  oglApp
//
//  Created by Simon Jordan on 20/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef oglApp_GUIController_h
#define oglApp_GUIController_h

#include "memoryManager.h"
#include "gameScreen.h"

class GUIController {
    
public:
    GUIController();
    ~GUIController();
    
    void addNewScreen(gameScreen* newscrn);
    
    gameScreen* getCurrentScreen();
    void setCurrentScreen(gameScreen* screen);
    
    void initScreens();
    void calcGUICol();
    
    std::vector<gameScreen*> getTotalGameScreens();
    
    gameScreen* getScreenAt(int num);
    
private:
    std::vector<gameScreen*> totalGameScreens;
    gameScreen* currentScreen;
    gameScreen* previousScreen;
};

#endif
