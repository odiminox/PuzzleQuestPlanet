//
//  GUIController.cpp
//  oglApp
//
//  Created by Simon Jordan on 20/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "GUIController.h"

GUIController::GUIController()
{
    currentScreen = NULL;
    previousScreen = NULL;
}
GUIController::~GUIController()
{
    
}

std::vector<gameScreen*> GUIController::getTotalGameScreens()
{
    return totalGameScreens;
}

void GUIController::addNewScreen(gameScreen* newscrn)
{
    if(NULL != newscrn)
        totalGameScreens.push_back(newscrn);
}

gameScreen* GUIController::getCurrentScreen()
{
    return currentScreen;
}
void GUIController::setCurrentScreen(gameScreen* screen)
{
    if(NULL != screen){
        if(NULL != currentScreen)
            previousScreen = currentScreen;
        
        currentScreen = screen;
        currentScreen->setIsCurrentScreen(true);
        if(NULL != previousScreen)
            previousScreen->setIsCurrentScreen(false);
    }
}

gameScreen* GUIController::getScreenAt(int num)
{
    return totalGameScreens[num];
}

//Currently filling with some test data
void GUIController::initScreens()
{
    //Init the game screen
    gameScreen* levelGUI = new gameScreen();
    levelGUI->getScreenRootNode()->initMeshData();
    levelGUI->getScreenRootNode()->initNode(levelGUI->getScreenRootNode()->getMeshData());
    
    levelGUI->getScreenRootNode()->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Brown Block.png");//Kind of a waste of loading in for no reason
    //Need to edit the mesh so it doesn't need to have a texuture, this works for now however.
    levelGUI->getScreenRootNode()->getMeshData()->setAlpha(0.0f);
    levelGUI->getScreenRootNode()->getNode()->scaleX(1.0f);
    levelGUI->getScreenRootNode()->getNode()->scaleY(1.0f);
    levelGUI->getScreenRootNode()->getNode()->translateX(0);
    levelGUI->getScreenRootNode()->getNode()->translateY(0);
    
    //Init the game screen elements
    screenElement* levelGUI_Score_Box = new screenElement();
    screenElement* levelGUI_Menu_Box = new screenElement();
    //Init the mesh and node data
    
    levelGUI_Score_Box->initMeshData();
    levelGUI_Score_Box->initNode(levelGUI_Score_Box->getMeshData());
    levelGUI_Menu_Box->initMeshData();
    levelGUI_Menu_Box->initNode(levelGUI_Menu_Box->getMeshData());
    
    //Assign the names
    levelGUI_Score_Box->setElementName("ScoreBox");
    levelGUI_Menu_Box->setElementName("MenuBox");
    //Init the element data
    levelGUI_Score_Box->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Brown Block.png");
    levelGUI_Score_Box->getNode()->scaleX(1.0f);
    levelGUI_Score_Box->getNode()->scaleY(1.0f);
    levelGUI_Score_Box->getNode()->scaleZ(1.0f);
    levelGUI_Score_Box->getNode()->translateX(-0.050);
    levelGUI_Score_Box->getNode()->translateY(0.070);
    levelGUI_Score_Box->getNode()->renderMe = true;
    
    levelGUI_Menu_Box->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Brown Block.png");
    levelGUI_Menu_Box->getNode()->scaleX(1.0f);
    levelGUI_Menu_Box->getNode()->scaleY(1.0f);
    levelGUI_Menu_Box->getNode()->scaleZ(1.0f);
    levelGUI_Menu_Box->getNode()->translateX(0.050);
    levelGUI_Menu_Box->getNode()->translateY(0.070);
    levelGUI_Menu_Box->getNode()->renderMe = true;
    //Add elements to root node in menu
    //levelGUI->getScreenRootNode()->getNode()->addChildNode(levelGUI_Score_Box->getNode());
    //levelGUI->getScreenRootNode()->getNode()->addChildNode(levelGUI_Menu_Box->getNode());
    
    addNewScreen(levelGUI);
    
    //Now init the screens
    setCurrentScreen(levelGUI);
    
}
void GUIController::calcGUICol()
{
    /*
    if(levelData->getIsTouched()){
        for(int i = 0; i < layerBlockCounter; ++i)
        {
            if(levelData->getCanDrag()){
                if(CGRectContainsPoint(totalLevelBlocks[i]->boundingBox(), levelData->getPoint())){
                    blockSelected = true;
                    blockNumberTouched = i;
                    //NSLog(@"blockNumberTouched: %d",blockNumberTouched);
                    
                }
            }
        }
    }
     */
}
