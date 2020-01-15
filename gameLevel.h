//
//  gameLevel.h
//  oglApp
//
//  Created by SimonJordan on 02/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
// The gameLevel class is responsible for the operation of the level mechanics, the collating of the levelData and how the user interacts with it
// it should be the responsibility of a meta controller class to handle the gamestate logic based on the events and data produced from the activities
// produced within this class
//

#ifndef oglApp_gameLevel_h
#define oglApp_gameLevel_h

#include <vector>
#include "memoryManager.h"
#include "camera.h"
#include "gridController.h"
#include "blockPiece.h"
#include <algorithm>


struct gridCell {
    bool isFree;
    int cellNum;
};

class gameLevel {

public:
    gameLevel();
    ~gameLevel();
    
    void initialiseGameLevel();
    void getScreenWorldWidthHeight(float width, float height, camera* viewportCamera);
    void cleanUpGameLevel();
    
    void setLevelLayersWidthHeight(int width, int height);
    
    bool isGridCellFree(int x, int y, gridCell** levelLayer);
    void setGridCellFree(int x, int y, gridCell** levelLayer);
    void setGridCellNotFree(int x, int y, gridCell** levelLayer);
    
    void growGridHeight(int newHeight);
    
    void setBlock(int xPos, int yPos, gridCell** levelLayer);
    
    void initialiseLevelLayers();
    
    void createNewLevelLayer();
    void removeNewLevelLayer();
    
    void startingLayers(int layerNum);
    int getStartLayerNum();
        
    void updateLevel(float delta);
    
    bool blockInGridCheck(int blockNum);
    
    float systemDelta;

    gridController* getLevelGridController();
private:
    gridController* GridCont;
    
    bool reverseAnimation;
    bool checkToReverse;
    
    int layerRenderOrderIDCounter;
    int blockRenderOrderIDCounter;
    
    gridCell** gameLevelGrid;
    
    std::vector<gridCell**> levelLayers;
    
    std::vector<blockPiece*> blockOrder;
    std::vector<blockPiece*> layerOrder;
    
    int levelBlockCounter;
    int levelLayerCounter;
    int initLayerNum;
    
    bool controlLocked;
    
    float layerYOffset;
    float blockOffset;
    
    camera* Levelcamera;
};



#endif
