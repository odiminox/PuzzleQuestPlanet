//
//  gameLevel.cpp
//  oglApp
//
//  Created by SimonJordan on 02/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "gameLevel.h"
#include <algorithm>
gameLevel::gameLevel()
{
    //levelData = new levelDataController();
    //rootLevelNode = new blockPiece();
    Levelcamera = new camera();
    GridCont = new gridController();
    GridCont->setLockInput(false);
    GridCont->setBlkSlktd(false);

    blockOffset = 0.0f;
    GridCont->setBlockNumberTouched(-1);
    
    //srand(time(NULL));
}
gameLevel::~gameLevel()
{
    cleanUpGameLevel();
}

gridController* gameLevel::getLevelGridController()
{
    return GridCont;
}

void gameLevel::initialiseGameLevel()
{
    GridCont->getLevelData()->initialiseLevelData();

    setLevelLayersWidthHeight(4, 4);
    
    layerYOffset = 0.0f;
    levelBlockCounter = 0;
    levelLayerCounter = 0;
    startingLayers(4);
    layerRenderOrderIDCounter = 0;
    blockRenderOrderIDCounter = 0;
    
    GridCont->setLBC(GridCont->getLevelData()->getGridX() * GridCont->getLevelData()->getGridY());
    
    //The root node will be placed at the center of the screen and the game world built up around it, to enable easy transformation
    //of level objects in the game world via the scene graph
    GridCont->getLevelData()->getRootNode()->initMeshData();
    GridCont->getLevelData()->getRootNode()->getMeshData()->loadTexture("/Users/simonjordan/Desktop/Puzzle Quest Planet/PlanetCute PNG/Brown Block.png");
    GridCont->getLevelData()->getRootNode()->initNode(GridCont->getLevelData()->getRootNode()->getMeshData());
    
    GridCont->getLevelData()->getRootNode()->getNode()->scaleX(1.0f);
    GridCont->getLevelData()->getRootNode()->getNode()->scaleY(1.0f);
    GridCont->getLevelData()->getRootNode()->getNode()->scaleZ(1.0f);
    
    GridCont->getLevelData()->getRootNode()->getNode()->translateX(0.0f);
    GridCont->getLevelData()->getRootNode()->getNode()->translateY(0.0f);
    GridCont->getLevelData()->getRootNode()->getNode()->translateZ(0.0f);
    
    checkToReverse = false;
    
    initialiseLevelLayers();
    
    GridCont->getLevelData()->setCanDrag(true);
}


void gameLevel::setBlock(int xPos, int yPos, gridCell** levelLayer)
{
    blockPiece* tempBlock = new blockPiece();
    tempBlock->initMeshData();
    tempBlock->initNode(tempBlock->getMeshData());

    tempBlock->getAnimCont()->setTranslateY(GridCont->getLevelData()->getBlockWidth());//This is fixed at a block width and height for all in the world, this can be set independantly however
    tempBlock->getAnimCont()->setTranslateX(GridCont->getLevelData()->getBlockHeight());
    
    //Need a seed like the time to ensure it is different each time and to also extend this generation with rules
    //to ensure that when block pieces are formed it does not create impossible arrangements.
    int randNum  = 0 + (rand() % (int)(4 - 0 + 1));
    //[0]plain dirt [1]plain stone [2]grass [3]dirt [4]stone [5]water
    
    //Assign the tempBlocks texture from the texure pool
    tempBlock->setBlockType(randNum);
    tempBlock->getMeshData()->pTexture = GridCont->getLevelData()->getTextureFromCache(randNum);
    
    //Should do the division once at start-up to avoid it each iteration
    //Only a 4x4 grid is placed in the middle, others are offset. Need to work out the issue there
    float temp =  ((xPos * 0.024)-(GridCont->getLevelData()->getScreenWorldWidth()/2));
    float temp2=  (((yPos * 0.020) + layerYOffset)-(GridCont->getLevelData()->getScreenWorldHeight()/2));
    
    tempBlock->setHomePosXY(temp, temp2);
    tempBlock->getNode()->translateX(temp);//Need to rename as it is confusing with anim translate [x,y], this is the position of the object in space
    tempBlock->getNode()->translateY(temp2);
    
    tempBlock->getNode()->scaleX(1);
    tempBlock->getNode()->scaleY(1);
    tempBlock->getNode()->scaleZ(1);
    
    tempBlock->setBlockGridXY(xPos, yPos);
    tempBlock->getNode()->setRenderOrderID(layerRenderOrderIDCounter);
    tempBlock->getNode()->setBlockRenderORderID(blockRenderOrderIDCounter);
    
    tempBlock->getNode()->renderMe = true;
    
    tempBlock->setNormWH(0.024, 0.020);
    
    GridCont->addToLPieceVec(tempBlock);
    
    setGridCellNotFree(xPos, yPos, levelLayer);
    levelBlockCounter++;
    blockRenderOrderIDCounter++;
}

void gameLevel::setLevelLayersWidthHeight(int width, int height)
{
    GridCont->getLevelData()->setGridXY(width, height);
    
    GridCont->getLevelData()->setLevelWidth(GridCont->getLevelData()->getBlockWidth() * GridCont->getLevelData()->getGridX());
    GridCont->getLevelData()->setLevelHeight(GridCont->getLevelData()->getLevelHeight() * GridCont->getLevelData()->getGridY());
}

//This will need to go into the levelDataController class
void gameLevel::getScreenWorldWidthHeight(float width, float height, camera* viewportCamera){
    glm::vec4 viewport = glm::vec4(0.0f, 0.0f, width, height);
    glm::mat4 tmpView = glm::lookAt(glm::vec3(viewportCamera->getCameraPosX(),viewportCamera->getCameraPosY(),viewportCamera->getCameraPosZ()),
                                    glm::vec3(viewportCamera->getForward().x,viewportCamera->getForward().y,viewportCamera->getForward().z),glm::vec3(0,1,0));
    glm::mat4 tmpProj = glm::perspective( 90.0f, width/height, 0.1f, 1000.0f);
    glm::vec3 screenPos = glm::vec3(width, height - 1, 0.0f);
    
    glm::vec3 worldPos = glm::unProject(screenPos, tmpView, tmpProj, viewport);
    
    GridCont->getLevelData()->setScreenWorldWidth(worldPos.x);
    GridCont->getLevelData()->setScreenWorldHeight(worldPos.y);

}

void gameLevel::startingLayers(int layerNum)
{
    initLayerNum = layerNum;
}

int gameLevel::getStartLayerNum()
{
    return initLayerNum;
}

void gameLevel::createNewLevelLayer()
{
    gridCell** initLevelLayer;//Create our new layer
    levelLayerCounter++;
    initLevelLayer = new gridCell*[GridCont->getLevelData()->getGridY()];//Assign how large we want it to be in the X and Y
    for(int i = 0; i < GridCont->getLevelData()->getGridY(); ++i){
        initLevelLayer[i] = new gridCell[GridCont->getLevelData()->getGridX()];
    }
    
    for(int i = 0; i < GridCont->getLevelData()->getGridX(); ++i)
    {
        for(int j = 0; j < GridCont->getLevelData()->getGridX(); ++j)
        {
            initLevelLayer[i][j] = *new gridCell();//Initialise all the cells with data
        }
    }
    
    levelLayers.push_back(initLevelLayer);//Add it to our level vector list so we can access it later
    
    
    for(int i =0 ; i <GridCont->getLevelData()->getGridY(); ++i){
        for (int j = 0; j < GridCont->getLevelData()->getGridX(); ++j) {//Initialise each of the blocks in the grid
            setBlock(i, j, initLevelLayer);
        }
    }
    //NSLog(@"%d",GridCont->getLPieces().size());
    for(int i = 0; i < GridCont->getLPieces().size(); ++i){
        //GridCont->getBBuffer().push_back(GridCont->getLPieceAt(i));
        GridCont->addToBlkBfferVec(GridCont->getLPieceAt(i));
    }

}



void gameLevel::initialiseLevelLayers()
{
    //How many layers do we want to start the game with?
    for(int i = 0; i < initLayerNum; ++i){
        createNewLevelLayer();

        GridCont->reorderBlocks();
        
        layerYOffset += 0.00955555f;
        layerRenderOrderIDCounter++;
        blockRenderOrderIDCounter = 0;
    }
    //NSLog(@"levelBlockCounter: %d",levelBlockCounter);
    GridCont->reorderLayers();
    
    GridCont->sortBlocks();
}
//
//Needs some major overhauling and cleaning up!
//
void gameLevel::updateLevel(float delta)
{
    systemDelta = delta;
    
    if(GridCont->getBlkSlktd()){
        for(int i = 0; i < GridCont->getTotLBlocks().size(); ++i){
            
            GridCont->getLBFromTotalAt(i)->getMeshData()->setBlue(1);
            GridCont->getLBFromTotalAt(i)->getMeshData()->setGreen(1);
            GridCont->getLBFromTotalAt(i)->getMeshData()->setRed(1);
        }
        GridCont->assignBlockNeighbourBufferToVec( GridCont->calNieghbBlocks(GridCont->getBlocNumTouch()));
        GridCont->setBlkSlktd(false);
    }
    if(GridCont->getLevelData()->getIsTouched()){
        GridCont->calcLevelCol();
    }
    
    if(GridCont->getBlkSlktd()){
        if(GridCont->getLevelData()->getSwipeRight()){
            GridCont->setSavedSwipeAction(1);
        }
        if(GridCont->getLevelData()->getSwipeLeft()){
            GridCont->setSavedSwipeAction(0);
        }
        if(GridCont->getLevelData()->getSwipeUp()){
            GridCont->setSavedSwipeAction(2);
        }
        if(GridCont->getLevelData()->getSwipeDown()){
            GridCont->setSavedSwipeAction(3);
        }
        
        GridCont->chk4NeighbBlocks();
        GridCont->chk3NeighbBlocks();
        GridCont->chk2NeighbBlocks();
    }
    
    if(!GridCont->getLevelData()->getCanDrag()){
        
        if(GridCont->getLBFromTotalAt(GridCont->getBlocNumTouch())->getAnimCont()->getAnimPlying()){
            
            GridCont->getLBFromTotalAt(GridCont->getBlocNumTouch())->getAnimCont()->animGameBlk();
            GridCont->getLBFromTotalAt(GridCont->getBlockAnimIndex())->getAnimCont()->animGameBlk();
        
        } else if(!GridCont->getLBFromTotalAt(GridCont->getBlocNumTouch())->getAnimCont()->getAnimPlying()){
            
            float tempx = GridCont->getLBFromTotalAt(GridCont->getBlocNumTouch())->getHomePos().x;
            float tempy = GridCont->getLBFromTotalAt(GridCont->getBlocNumTouch())->getHomePos().y;

            GridCont->getLBFromTotalAt(GridCont->getBlocNumTouch())->setHomePosXY(GridCont->getLBFromTotalAt(GridCont->getBlockAnimIndex())->getHomePos().x,
                                                                                  GridCont->getLBFromTotalAt(GridCont->getBlockAnimIndex())->getHomePos().y);
            
            GridCont->getLBFromTotalAt(GridCont->getBlockAnimIndex())->setHomePosXY(tempx, tempy);

            int tempID = GridCont->getLBFromTotalAt(GridCont->getBlockAnimIndex())->getNode()->getBlockRenderOrderID();
            int tempID2 = GridCont->getLBFromTotalAt(GridCont->getBlocNumTouch())->getNode()->getBlockRenderOrderID();       
 
            GridCont->getLBFromTotalAt(GridCont->getBlocNumTouch())->getNode()->setBlockRenderORderID(tempID);
            GridCont->getLBFromTotalAt(GridCont->getBlockAnimIndex())->getNode()->setBlockRenderORderID(tempID2);
            
            //Bit of an annoying glitch, as the blocks are not sorted until they finish the animations, you can
            //see through one of the blocks very briefly
            GridCont->sortBlocks();
            
            GridCont->setSvdBlkAnim(GridCont->getBlockAnimIndex());
            GridCont->setSvdBlkTouch(GridCont->getBlocNumTouch());
            
            checkToReverse = true;
            GridCont->getLevelData()->setCanDrag(true);
            GridCont->setBlockNumberTouched(-1);
            GridCont->setBlockAnimIndex(-1);
        }
    }   

    if(checkToReverse){
        checkToReverse = false;
        if(!GridCont->detIfMatchRemove(GridCont->getSvdBlkAnim(), GridCont->getSvdBlkTouch())){
            reverseAnimation = true;
        } else{
            // GridCont->sortBlocks();
        }
    }
    
    
    if(GridCont->checkForPendingSecondaryAnims()){
        GridCont->updateBlockSecondaryAnims();
    } else if(!GridCont->checkForPendingSecondaryAnims()){
        // GridCont->sortBlocks();
    }
    
    //This is initiated if we swiped the block, but there was not a match available, so we swap back to the default positions
    //Code duplicated from above, can be refactored out into a function
    if(reverseAnimation){
        GridCont->getLBFromTotalAt(GridCont->getSvdBlkTouch())->getAnimCont()->animGameBlk();
        GridCont->getLBFromTotalAt(GridCont->getSvdBlkAnim())->getAnimCont()->animGameBlk();
        
        if(!GridCont->getLBFromTotalAt(GridCont->getSvdBlkTouch())->getAnimCont()->getAnimPlying()){
            float tempx = GridCont->getLBFromTotalAt(GridCont->getSvdBlkTouch())->getHomePos().x;
            float tempy = GridCont->getLBFromTotalAt(GridCont->getSvdBlkTouch())->getHomePos().y;
            
            GridCont->getLBFromTotalAt(GridCont->getSvdBlkTouch())->setHomePosXY(GridCont->getLBFromTotalAt(GridCont->getSvdBlkAnim())->getHomePos().x,
                                                                                 GridCont->getLBFromTotalAt(GridCont->getSvdBlkAnim())->getHomePos().y);
            GridCont->getLBFromTotalAt(GridCont->getSvdBlkAnim())->setHomePosXY(tempx,tempy);
            
            int tempID = GridCont->getLBFromTotalAt(GridCont->getSvdBlkAnim())->getNode()->getBlockRenderOrderID();
            int tempID2 = GridCont->getLBFromTotalAt(GridCont->getSvdBlkTouch())->getNode()->getBlockRenderOrderID();
            
            GridCont->getLBFromTotalAt(GridCont->getSvdBlkTouch())->getNode()->setBlockRenderORderID(tempID);
            GridCont->getLBFromTotalAt(GridCont->getSvdBlkAnim())->getNode()->setBlockRenderORderID(tempID2);
            
            GridCont->setSvdBlkAnim(-1);
            GridCont->setSvdBlkTouch(-1);
            GridCont->getLevelData()->setCanDrag(true);
            //Bit of an annoying glitch, as the blocks are not sorted until they finish the animations, you can
            //see through one of the blocks very briefly
            GridCont->sortBlocks();
            reverseAnimation = false;
        }
    }
    

     //GridCont->updateBlockSecondaryAnims();

    
    //It is here where we will process secondary animations
    //Secondary animations can be playing regardless of other animations that are taking place
    //We will have a vector list of current blocks to animate and then loop through them
    //once a block has reached the end of its animation, we will remove it from the animation list
    
    
}


bool gameLevel::blockInGridCheck(int blockNum)
{
    return true;
}

void gameLevel::cleanUpGameLevel()
{
    for (int i = 0; i < GridCont->getLevelData()->getGridY(); ++i)
            safeDelete(gameLevelGrid[i]);
    safeDelete(gameLevelGrid);
    
    safeDelete(Levelcamera);
    safeDelete(GridCont);
}

void gameLevel::growGridHeight(int newHeight)
{
    
}

void gameLevel::setGridCellFree(int x, int y, gridCell** levelLayer)
{
    levelLayer[x][y].isFree = true;
}

void gameLevel::setGridCellNotFree(int x, int y, gridCell** levelLayer)
{
    levelLayer[x][y].isFree = false;
}

bool gameLevel::isGridCellFree(int x, int y, gridCell** levelLayer)
{
    return levelLayer[x][y].isFree;
}




