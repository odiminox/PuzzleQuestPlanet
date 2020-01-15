//
//  gridController.cpp
//  oglApp
//
//  Created by Simon Jordan on 16/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "gridController.h"

gridController::gridController()
{
    levelData = new levelDataController();
    dirtyNodes = false;
}
gridController::~gridController()
{
    safeDelete(levelData);
}

levelDataController* gridController::getLevelData()
{
    return levelData;
}

void gridController::setLBC(int counter)
{
    layerBlockCounter = counter;
}

int gridController::getLBC()
{
    return layerBlockCounter;
}

int gridController::getBlocNumTouch()
{
    return blockNumberTouched;
}
void gridController::setBlockNumberTouched(int num)
{
    blockNumberTouched = num;
}

std::vector<blockPiece*> gridController::getLPieces()
{
    return levelPieces;
}
std::vector<blockPiece*> gridController::getBBuffer()
{
    return blockBuffer;
}
std::vector<blockPiece*> gridController::getTotLBlocks()
{
    return totalLevelBlocks;
}

void gridController::addToLPieceVec(blockPiece* blkPiece)
{
    levelPieces.push_back(blkPiece);
}

void gridController::addToBlkBfferVec(blockPiece* blkPiece)
{
    blockBuffer.push_back(blkPiece);
}

blockPiece* gridController::getLPieceAt(int index)
{
    return levelPieces[index];
}
blockPiece* gridController::getBBAt(int index)
{
    return blockBuffer[index];
}
blockPiece* gridController::getLBFromTotalAt(int index)
{
    return totalLevelBlocks[index];
}

std::vector<int> gridController::getBlockNeighbBuffer()
{
    return blockNeighbourBuffer;
}

int gridController::getBlockNeighbBufferAt(int index)
{
    return blockNeighbourBuffer[index];
}

void gridController::assignLevelPiecesToVec(std::vector<blockPiece*> vec)
{
    levelPieces = vec;
}
void gridController::assignBlockBufferToVec(std::vector<blockPiece*> vec)
{
    blockBuffer = vec;
}
void gridController::assignTotalLevelBlocksToVec(std::vector<blockPiece*> vec)
{
    totalLevelBlocks = vec;
}
void gridController::assignBlockNeighbourBufferToVec(std::vector<int> vec)
{
    blockNeighbourBuffer = vec;
}

void gridController::setSavedSwipeAction(int num)
{
    savedSwipeAction = num;
}
int gridController::getSavedSwipeAction()
{
    return savedSwipeAction;
}

int gridController::getBlockAnimIndex()
{
    return blockAnimIndex;
}
void gridController::setBlockAnimIndex(int num)
{
    blockAnimIndex = num;
}

void gridController::setSvdBlkAnim(int num)
{
    savedBlockAnim = num;
}
int gridController::getSvdBlkAnim()
{
    return savedBlockAnim;
}
void gridController::setSvdBlkTouch(int num)
{
    savedBlockTouched = num;
}
int gridController::getSvdBlkTouch()
{
    return savedBlockTouched;
}

void gridController::setBlkSlktd(bool blkslktd)
{
    blockSelected = blkslktd;
}
bool gridController::getBlkSlktd()
{
    return blockSelected;
}

bool gridController::getAreNodesDirty()
{
    return dirtyNodes;
}
void gridController::setAreNodesDirty(bool nodes)
{
    dirtyNodes = nodes;
}

void gridController::setLockInput(bool input)
{
    lockInput = input;
}
bool gridController::getLockInput()
{
    return lockInput;
}

void gridController::calcLevelCol()
{
    if(levelData->getIsTouched()){
        for(int i = 0; i < layerBlockCounter; ++i)
        {
            if(levelData->getCanDrag()){
                //if(!lockInput){
                    if(CGRectContainsPoint(totalLevelBlocks[i]->boundingBox(), levelData->getPoint())){
                        blockSelected = true;
                        blockNumberTouched = i;
                        //NSLog(@"blockNumberTouched: %d",blockNumberTouched);
                    }
                //}
            }
        }
    }
}

std::vector<int> gridController::calNieghbBlocks(int blockNumber)
{
    int neighboutCounter = 0;
    std::vector<int> neighbourPieces;
    
    for(int i = 0; i < layerBlockCounter; ++i){
        
        if(i == blockNumber)
            continue;
        
        float distance = glm::distance(totalLevelBlocks[blockNumber]->getHomePos(), totalLevelBlocks[i]->getHomePos());
        //Get horizontal blocks
        if((distance - 0.024 <= 0.01f) && (totalLevelBlocks[i]->getHomePos().y == totalLevelBlocks[blockNumber]->getHomePos().y)){
            
             totalLevelBlocks[i]->getMeshData()->setRed(0);
             totalLevelBlocks[i]->getMeshData()->setGreen(1);
             totalLevelBlocks[i]->getMeshData()->setBlue(0);
             
            neighbourPieces.push_back(i);
            neighboutCounter++;
        }//Get vertical blocks
        
        if((distance - 0.022 <= 0.01f) && (totalLevelBlocks[i]->getHomePos().x == totalLevelBlocks[blockNumber]->getHomePos().x)){
            
             totalLevelBlocks[i]->getMeshData()->setRed(0);
             totalLevelBlocks[i]->getMeshData()->setGreen(0);
             totalLevelBlocks[i]->getMeshData()->setBlue(0);
             
            neighbourPieces.push_back(i);
            neighboutCounter++;
        }
        //Blocks spawn in order: [LEFT, DOWN, UP, DOWN], [0,1,2,3]
    }
    return neighbourPieces;    
}

//Should refactor this out into a level animation class
void gridController::chkSwipeDAnim(int blockTouched, int neighbourIndex)
{
    if(levelData->getSwipeDown() && blockSelected){
        //I should refactor this out into a function to neaten it up
        totalLevelBlocks[blockTouched]->getAnimCont()->setAnimBlk(3);//Set what animation we want for the block touched, then set up the movement animations data
        totalLevelBlocks[blockTouched]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockTouched]->getAnimCont()->getTranslateX(),
                                                                                 totalLevelBlocks[blockTouched]->getAnimCont()->getTranslateY(), 0.00666);
        
        totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->setAnimBlk(2);//Do the same for the target block
        totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->getTranslateX(),
                                                                                                         totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->getTranslateY(), 0.00666);
        blockAnimIndex = blockNeighbourBuffer[neighbourIndex];
        blockSelected = false;
        levelData->setCanDrag(false);
    }
}
void gridController::chkSwipeUAnim(int blockTouched, int neighbourIndex)
{
    if(levelData->getSwipeUp() && blockSelected){
        
        totalLevelBlocks[blockTouched]->getAnimCont()->setAnimBlk(2);
        totalLevelBlocks[blockTouched]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockTouched]->getAnimCont()->getTranslateX(),
                                                                    totalLevelBlocks[blockTouched]->getAnimCont()->getTranslateY(), 0.00666);
        
        totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->setAnimBlk(3);
        totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->getTranslateX(),
                                                                                            totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->getTranslateY(), 0.00666);
        
        blockAnimIndex = blockNeighbourBuffer[neighbourIndex];
        blockSelected = false;
        levelData->setCanDrag(false);
    }
}
void gridController::chkSwipeLAnim(int blockTouched, int neighbourIndex)
{
    if(levelData->getSwipeLeft() && blockSelected){
        
        totalLevelBlocks[blockTouched]->getAnimCont()->setAnimBlk(1);
        totalLevelBlocks[blockTouched]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockTouched]->getAnimCont()->getTranslateX(),
                                                                    totalLevelBlocks[blockTouched]->getAnimCont()->getTranslateY(), 0);
        
        totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->setAnimBlk(0);
        totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->getTranslateX(),
                                                                                            totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->getTranslateY(), 0);
        
        blockAnimIndex = blockNeighbourBuffer[neighbourIndex];
        blockSelected = false;
        levelData->setCanDrag(false);
    }
}
void gridController::chkSwipeRAnim(int blockTouched, int neighbourIndex)
{
    if(levelData->getSwipeRight() && blockSelected){
        
        totalLevelBlocks[blockTouched]->getAnimCont()->setAnimBlk(0);
        totalLevelBlocks[blockTouched]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockTouched]->getAnimCont()->getTranslateX(),
                                                                    totalLevelBlocks[blockTouched]->getAnimCont()->getTranslateY(), 0);
        
        totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->setAnimBlk(1);
        totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->getTranslateX(),
                                                                                            totalLevelBlocks[blockNeighbourBuffer[neighbourIndex]]->getAnimCont()->getTranslateY(), 0);
        
        blockAnimIndex = blockNeighbourBuffer[neighbourIndex];
        blockSelected = false;
        levelData->setCanDrag(false);
    }
    
}

void gridController::detBLClicked()
{
    if(blockNumberTouched == 0){
        if(levelData->getSwipeRight() && blockSelected){
            
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->setAnimBlk(0);
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateX(),
                                                                        totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateY(), 0);
            
            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->setAnimBlk(1);
            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->getTranslateX(),
                                                                                            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->getTranslateY(), 0);
            
            blockAnimIndex = blockNeighbourBuffer[1];
            blockSelected = false;
            levelData->setCanDrag(false);
        }
        if(levelData->getSwipeUp() && blockSelected){
            
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->setAnimBlk(2);
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateX(),
                                                                              totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateY(), 0.00666);
            
            totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->setAnimBlk(3);
            totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->getTranslateX(),
                                                                                   totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->getTranslateY(), 0.00666);
            
            blockAnimIndex = blockNeighbourBuffer[0];
            blockSelected = false;
            levelData->setCanDrag(false);
        }
    }
}
void gridController::detTRClicked()
{
    if(blockNumberTouched == ((levelData->getGridX()*levelData->getGridY())-1)){
        if(levelData->getSwipeLeft() && blockSelected){
            
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->setAnimBlk(1);
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateX(),
                                                                                          totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateY(), 0);
            
            totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->setAnimBlk(0);
            totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->getTranslateX(),
                                                                                               totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->getTranslateY(), 0);
            
            blockAnimIndex = blockNeighbourBuffer[0];
            blockSelected = false;
            levelData->setCanDrag(false);
        }
        if(levelData->getSwipeDown() && blockSelected){
            
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->setAnimBlk(3);
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateX(),
                                                                                          totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateY(), 0.00666);
            
            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->setAnimBlk(2);
            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->getTranslateX(),
                                                                                               totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->getTranslateY(), 0.00666);
            
            blockAnimIndex = blockNeighbourBuffer[1];
            blockSelected = false;
            levelData->setCanDrag(false);
        }
    }
}
void gridController::detTLClicked()
{
    if(blockNumberTouched == (levelData->getGridX()-1)){
        if(levelData->getSwipeDown() && blockSelected){
            
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->setAnimBlk(3);
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateX(),
                                                                                          totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateY(), 0.00666);
            
            totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->setAnimBlk(2);
            totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->getTranslateX(),
                                                                                               totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->getTranslateY(), 0.00666);
            
            blockAnimIndex = blockNeighbourBuffer[0];
            blockSelected = false;
            levelData->setCanDrag(false);
        }
        
        if(levelData->getSwipeRight() && blockSelected){
            
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->setAnimBlk(0);
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateX(),
                                                                                          totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateY(), 0);
            
            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->setAnimBlk(1);
            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->getTranslateX(),
                                                                                               totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->getTranslateY(), 0);
            
            blockAnimIndex = blockNeighbourBuffer[1];
            blockSelected = false;
            levelData->setCanDrag(false);
        }
    }
}
void gridController::detBRClicked()
{
    if(blockNumberTouched == (levelData->getGridX()*levelData->getGridY()) - levelData->getGridX()){
        if(levelData->getSwipeUp() && blockSelected){
            
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->setAnimBlk(2);
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateX(),
                                                                                          totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateY(), 0.00666);
            
            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->setAnimBlk(3);
            totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->animMoveData(0.020, 0.1, totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->getTranslateX(),
                                                                                               totalLevelBlocks[blockNeighbourBuffer[1]]->getAnimCont()->getTranslateY(), 0.00666);
            
            blockAnimIndex = blockNeighbourBuffer[1];
            blockSelected = false;
            levelData->setCanDrag(false);
        }
        if(levelData->getSwipeLeft() && blockSelected){
            
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->setAnimBlk(1);
            totalLevelBlocks[blockNumberTouched]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateX(),
                                                                                          totalLevelBlocks[blockNumberTouched]->getAnimCont()->getTranslateY(), 0);
            
            totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->setAnimBlk(0);
            totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->animMoveData(0.024, 0.1, totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->getTranslateX(),
                                                                                               totalLevelBlocks[blockNeighbourBuffer[0]]->getAnimCont()->getTranslateY(), 0);
            
            blockAnimIndex = blockNeighbourBuffer[0];
            blockSelected = false;
            levelData->setCanDrag(false);
        }
    }
}

void gridController::chk4NeighbBlocks()
{
    if(blockNeighbourBuffer.size() == 4){
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setRed(1);
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setGreen(1);
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setBlue(0);
        
        chkSwipeRAnim(blockNumberTouched, 3);
        chkSwipeLAnim(blockNumberTouched, 0);
        chkSwipeUAnim(blockNumberTouched, 2);
        chkSwipeDAnim(blockNumberTouched, 1);
        
    }
}
void gridController::chk3NeighbBlocks()
{
    if(blockNeighbourBuffer.size() == 3){
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setRed(0);
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setGreen(1);
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setBlue(1);
        
        detLSClicked();
        detRSClicked();
        detBClicked();
        detTClicked();
    }
}
void gridController::chk2NeighbBlocks()
{
    if(blockNeighbourBuffer.size() == 2){
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setRed(1);
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setGreen(0);
                          totalLevelBlocks[blockNumberTouched]->getMeshData()->setBlue(1);
        
        detBLClicked();
        detTLClicked();
        detTRClicked();
        detBRClicked();
    }
    
}

void gridController::detLSClicked()
{
    int rangeY;
    rangeY = (levelData->getGridY()-1);
    for(int i = 1; i < rangeY; ++i){
        if(blockNumberTouched == i){
            
            chkSwipeRAnim(blockNumberTouched, 2);
            chkSwipeUAnim(blockNumberTouched, 1);
            chkSwipeDAnim(blockNumberTouched, 0);
        }
    }
    
}
void gridController::detRSClicked()
{
    int rangeEndY;
    int rangeStartY;
    rangeEndY = ((levelData->getGridX() * levelData->getGridY()) - 1);
    rangeStartY = (rangeEndY -(levelData->getGridY() -1));
    for(int i = rangeStartY; i <rangeEndY;++i)
    {
        if(blockNumberTouched == i){
            chkSwipeLAnim(blockNumberTouched, 0);
            chkSwipeDAnim(blockNumberTouched, 1);
            chkSwipeUAnim(blockNumberTouched, 2);
        }
    }
}
void gridController::detTClicked()
{
    int rangeStartY;
    rangeStartY = ((levelData->getGridX() * 2) - 1);
    for(int i = rangeStartY; i < (layerBlockCounter-1); i+=levelData->getGridX()){
        if(blockNumberTouched == i){
            
            chkSwipeLAnim(blockNumberTouched, 0);
            chkSwipeDAnim(blockNumberTouched, 1);
            chkSwipeRAnim(blockNumberTouched, 2);
        }
    }
    
}
void gridController::detBClicked()
{
    for(int i = levelData->getGridX(); i< (levelData->getGridX() * 3); i+=levelData->getGridX()){
        if(blockNumberTouched == i){
            
            chkSwipeLAnim(blockNumberTouched, 0);
            chkSwipeUAnim(blockNumberTouched, 1);
            chkSwipeRAnim(blockNumberTouched, 2);
        }
    }
}


//Potential bounds checking issue whereby it will recuersively look for next neighbour elements in a different column or row
void gridController::checkHorizontalLineLeft(int blockA, int blockB)
{
    
    if(totalLevelBlocks[blockA]->getBlockType() == totalLevelBlocks[blockB]->getBlockType()){
        
        horizontalMatches.push_back(blockA);
        
        int gridNumCheck = (blockA - levelData->getGridX());
        if(gridNumCheck < 0)
            return;
        
        checkHorizontalLineLeft(gridNumCheck, blockA);
    }
    
}
void gridController::checkHorizontalLineRight(int blockA, int blockB)
{

    if(totalLevelBlocks[blockA]->getBlockType() == totalLevelBlocks[blockB]->getBlockType()){
        
        horizontalMatches.push_back(blockA);
        
        int gridNumCheck = (blockA + levelData->getGridX());
        if(gridNumCheck > (levelData->getGridX()*levelData->getGridY()-1))
            return;
        
        checkHorizontalLineRight(gridNumCheck, blockA);
    }
}
void gridController::checkVerticleLineUp(int blockA, int blockB)
{    
    if(totalLevelBlocks[blockA]->getBlockType() == totalLevelBlocks[blockB]->getBlockType()){
        verticleMatches.push_back(blockA);
        
        int gridNumCheck = (blockA+1);
        if(gridNumCheck > (levelData->getGridX()*levelData->getGridY()-1))
            return;
        
        checkVerticleLineUp(gridNumCheck, blockA);
    }
}
void gridController::checkVerticleLineDown(int blockA, int blockB)
{
    if(totalLevelBlocks[blockA]->getBlockType() == totalLevelBlocks[blockB]->getBlockType()){
        verticleMatches.push_back(blockA);
        
        int gridNumCheck = (blockA-1);
        if(gridNumCheck < 0)
            return;
        
        checkVerticleLineDown(gridNumCheck, blockA);
    }
}

bool gridController::detIfMatchRemove(int blockToCheck, int blockTouched)
{
    blocksToCheck = calNieghbBlocks(blockToCheck);//We get all of the surrounding neighbour blocks
    bool runVerticleErase = false;
    bool runHorizontalErase = false;
    int horizontalCounter = 0;
    int verticleCounter = 0;
    
    //We want to check against all of the neighbour blocks, starting with the bottom-most entry, working around clock-wise
    for(int i = 0; i < blocksToCheck.size(); ++i){
        
        if(i == blockToCheck)//We don't want to check against ourself
            break;
        
        //This is the initial check that looks to see if we have matches with any off the surrounding neighbours, we then need to navigate them
         if(totalLevelBlocks[blocksToCheck[i]]->getBlockType() == totalLevelBlocks[blockToCheck]->getBlockType()){

             NSLog(@"Match");
             //Horizontal Block
             if(totalLevelBlocks[blocksToCheck[i]]->getHomePos().y == totalLevelBlocks[blockToCheck]->getHomePos().y)
             {
                  NSLog(@"Horizontal");
                 //We are on the right side of the block
                 if(totalLevelBlocks[blocksToCheck[i]]->getHomePos().x >= totalLevelBlocks[blockToCheck]->getHomePos().x){
                  NSLog(@"Right side");
                     checkHorizontalLineRight(blocksToCheck[i], blockToCheck);
                     horizontalCounter++;
                 //We are on the left side of the block
                 } else if(totalLevelBlocks[blocksToCheck[i]]->getHomePos().x <= totalLevelBlocks[blockToCheck]->getHomePos().x){
                      NSLog(@"Left side");
                     checkHorizontalLineLeft(blocksToCheck[i], blockToCheck);
                     horizontalCounter++;
                 }
             }
             //Verticle Block
             if(totalLevelBlocks[blocksToCheck[i]]->getHomePos().x == totalLevelBlocks[blockToCheck]->getHomePos().x)
             {
                  NSLog(@"Verticle");
                 //We are above the block
                 if(totalLevelBlocks[blocksToCheck[i]]->getHomePos().y >= totalLevelBlocks[blockToCheck]->getHomePos().y){
                   NSLog(@"Above");
                     checkVerticleLineUp(blocksToCheck[i], blockToCheck);
                     verticleCounter++;
                     
                 //We are below the block
                 } else if(totalLevelBlocks[blocksToCheck[i]]->getHomePos().y <= totalLevelBlocks[blockToCheck]->getHomePos().y){
                      NSLog(@"Below");
                     checkVerticleLineDown(blocksToCheck[i], blockToCheck);
                     verticleCounter++;
                 }
             }
         }
    }

    if(horizontalCounter > 1){
        runHorizontalErase = true;
        horizontalMatches.push_back(blockToCheck);
    }
    else{
        horizontalMatches.clear();
    }
    
    if(verticleCounter > 1){
        runVerticleErase = true;
        verticleMatches.push_back(blockToCheck);
    }
    else{
        verticleMatches.clear();
    }
    
    for(int i = 0; i < verticleMatches.size(); ++i){
        NSLog(@"vm: %d",verticleMatches[i]);
    }
    for(int i = 0; i < horizontalMatches.size(); ++i){
        NSLog(@"hm: %d",horizontalMatches[i]);
    }
    
    
    //Before we erase, we need to save the data from the blocks we are about to remove to init the new blocks to send in
    
    //Once the blocks are removed, we need to add new blocks.
    //Save the data from the blocks that have been removed, so we can assign this to the new blocks, like we do when we swap them
    if(runHorizontalErase)
    {
        //int middle = horizontalMatches.size() /2;
        //horizontalMatches.insert(horizontalMatches.begin() + middle, blockToCheck);
        
        NSLog(@"Erasing horizontal line");
        int hCounter = 0;
        for(int i = 0; i < totalLevelBlocks.size(); ++i){
            for(int j = 0; j < horizontalMatches.size(); ++j){
                if(horizontalMatches[j] == i){
                    //totalLevelBlocks.erase(totalLevelBlocks.begin()+(i-hCounter));

                   // hCounter++;//We need this, because we just removed an element from the list, so must offset the data
                    //Could neaten this up into a new function to remove the clutter
                    blockPiece* tempBlock = new blockPiece();
                    tempBlock->initMeshData();
                    tempBlock->initNode(tempBlock->getMeshData());
                    
                    tempBlock->getAnimCont()->setTranslateY(levelData->getBlockWidth());
                    tempBlock->getAnimCont()->setTranslateX(levelData->getBlockHeight());
                    
                    int randNum  = 0 + (rand() % (int)(4 - 0 + 1));
                    //[0]plain dirt [1]plain stone [2]grass [3]dirt [4]stone [5]water
                    //Assign the tempBlocks texture from the texure pool
                    
                    tempBlock->setBlockType(randNum);
                    tempBlock->getMeshData()->pTexture = levelData->getTextureFromCache(randNum);
                    
                    tempBlock->setHomePosXY(totalLevelBlocks[(horizontalMatches[j]-hCounter)]->getHomePos().x, totalLevelBlocks[(horizontalMatches[j]-hCounter)]->getHomePos().y );
                                        
                    tempBlock->getNode()->translateX(totalLevelBlocks[(horizontalMatches[j]-hCounter)]->getHomePos().x);
                    tempBlock->getNode()->translateY(totalLevelBlocks[(horizontalMatches[j]-hCounter)]->getHomePos().y);
                    //iowqqiwqw
                    tempBlock->getNode()->scaleX(0.1);
                    tempBlock->getNode()->scaleY(0.1);
                    tempBlock->getNode()->scaleZ(1);
                    
                    tempBlock->setBlockGridXY(totalLevelBlocks[(horizontalMatches[j]-hCounter)]->getGridBlockX(), totalLevelBlocks[(horizontalMatches[j]-hCounter)]->getGridBlockY());
                    tempBlock->getNode()->setRenderOrderID(totalLevelBlocks[(horizontalMatches[j]-hCounter)]->getNode()->getRenderOrderID());
                    tempBlock->getNode()->setBlockRenderORderID(totalLevelBlocks[(horizontalMatches[j]-hCounter)]->getNode()->getBlockRenderOrderID());
                    
                    tempBlock->getNode()->renderMe = true;
                    
                    tempBlock->setNormWH(0.024, 0.020);
                    tempBlock->getAnimCont()->animScaleUpData(1.0f, 0.01);
                    tempBlock->getAnimCont()->setSecondAnimaBlk(1);
                   
                    tempBlock->setNeedsToAnimate(true);
                    horizontalBlocksToAdd.push_back(tempBlock);
                    
                    //totalLevelBlocks.erase(totalLevelBlocks.begin()+(horizontalMatches[j]-hCounter));
                    blocksToAnimate.push_back(totalLevelBlocks[(horizontalMatches[j]-hCounter)]);
                    hCounter++;
                }
            }
        }
    }
    //Verticle goes here
        //We now have all of our new blocks to add, it is time to order them and animate them into the scene
     NSLog(@"horizontalBlocksToAdd size: %ld", horizontalBlocksToAdd.size());
     
     for(int i = 0; i < horizontalBlocksToAdd.size(); ++i){
     NSLog(@"num %f hpos X: %f hpos Y: %f blckGrdX %d blckGrdY %d ordId %f blkOrdID %f",totalLevelBlocks[horizontalMatches[i]]->getNode()->getBlockRenderOrderID() , totalLevelBlocks[horizontalMatches[i]]->getHomePos().x, totalLevelBlocks[horizontalMatches[i]]->getHomePos().y, totalLevelBlocks[horizontalMatches[i]]->getGridBlockX(), totalLevelBlocks[horizontalMatches[i]]->getGridBlockY(), totalLevelBlocks[horizontalMatches[i]]->getNode()->getRenderOrderID(), totalLevelBlocks[horizontalMatches[i]]->getNode()->getBlockRenderOrderID());
     }
    
    
    //For some reason cannot be an || statement, otherwise it glitches and returns???
    if(horizontalCounter >= 2){
        //sortBlocks(horizontalBlocksToAdd, horizontalBlocksToAdd.size());
         // sortBlocks();
        for(int i = 0; i < horizontalBlocksToAdd.size(); ++i){
            //totalLevelBlocks.push_back(horizontalBlocksToAdd[i]);
            //blocksToAnimate.push_back(horizontalBlocksToAdd[i]);
        }
        dirtyNodes = true;
        sortBlocks();
    
        //horizontalBlocksToAdd.clear();
        horizontalMatches.clear();
        lockInput = true; // we don't want the user messing with the grid whilst new blocks animate in
        //levelData->setCanDrag(false);
        //NSLog(@"totalLevelBlocks size: %ld",totalLevelBlocks.size());
        savedSwipeAction = -1;
        return true;
    }//This won't execute currently
    if(verticleCounter >= 2){        
        for(int i = 0; i < verticleBlocksToAdd.size(); ++i){
            totalLevelBlocks.push_back(verticleBlocksToAdd[i]);
        }
        verticleMatches.clear();
        return true;
    }
    
    //We have not been able to make a match of at least 3, so we must return the blocks back to their home positions.
    if(horizontalCounter || verticleCounter < 2){
        switch(savedSwipeAction)
        {
            case 0:
            {
                totalLevelBlocks[blockToCheck]->getAnimCont()->setAnimBlk(0);
                totalLevelBlocks[blockTouched]->getAnimCont()->setAnimBlk(1);
                break;
            }
            case 1:
            {
                totalLevelBlocks[blockToCheck]->getAnimCont()->setAnimBlk(1);
                totalLevelBlocks[blockTouched]->getAnimCont()->setAnimBlk(0);
                break;
            }
            case 2:
            {
                totalLevelBlocks[blockToCheck]->getAnimCont()->setAnimBlk(3);
                totalLevelBlocks[blockTouched]->getAnimCont()->setAnimBlk(2);
                break;
            }
            case 3:
            {
                totalLevelBlocks[blockToCheck]->getAnimCont()->setAnimBlk(2);
                totalLevelBlocks[blockTouched]->getAnimCont()->setAnimBlk(3);
                break;
            }
            default:
                break;
        };
        return false;
        
    }
    savedSwipeAction = -1;
    return false;
}

void gridController::updateBlockSecondaryAnims()
{
    for(int i = 0; i < blocksToAnimate.size(); ++i){
        
        
        if(blocksToAnimate[i]->getAnimCont()->getAnimPlying()){//If we have a secondary anim pending, play it
            blocksToAnimate[i]->getAnimCont()->animGameBlk();
        } else  if(!blocksToAnimate[i]->getAnimCont()->getAnimPlying()){
            // sortBlocks();
            blocksToAnimate[i]->setNeedsToAnimate(false);
        }
        /*
        if(!blocksToAnimate[i]->getAnimCont()->getAnimPlying() && !blocksToAnimate[i]->getAnimCont()->getSecondAnimPlying()){
            blocksToAnimate.erase(blocksToAnimate.begin()+i);//If both animations are done, remove from animation liust
        }
         */

    }
}
//Possibly not the best way to do this, but it should work for now
bool gridController::checkForPendingSecondaryAnims()
{
    for(int i = 0; i < totalLevelBlocks.size(); ++i){
        if(totalLevelBlocks[i]->getNeedsToAnimate()){
            return true;
        }
    }
    return false;
}


//Should refactor this out into a sprite ordering class
void gridController::reorderBlocks()
{
    blockBuffer.clear();
    
    for(int i = 0; i < levelPieces.size(); ++i){
        blockBuffer.push_back(levelPieces[i]);
    }
    
    //Change the rendering order of the blocks in the layer
    std::sort(blockBuffer.begin(), blockBuffer.end(), compareBlockID);
    
    //after it is all sorted, add to the total blocks of the level
    for(int i =0; i < blockBuffer.size(); ++i){
        totalLevelBlocks.push_back(blockBuffer[i]);
    }
    
    levelPieces.clear();
}

void gridController::sortBlocks(std::vector<blockPiece*> vecToSort, int numToSort)
{
    blockBuffer.clear();
    
    for(int i = 0;i < numToSort; ++i)
        blockBuffer.push_back(vecToSort[i]);
    
    std::sort(blockBuffer.begin(), blockBuffer.end(), compareBlockID);
    
    vecToSort.erase(vecToSort.begin(), vecToSort.begin()+numToSort);
    vecToSort.insert(vecToSort.begin(), blockBuffer.begin(), blockBuffer.end());
    
    //reorderLayers(vecToSort);
}
void gridController::reorderLayers(std::vector<blockPiece*> vecToSort)
{
    
}

//Massively lazy way to do this, but works for now...
void gridController::sortBlocks()
{
    blockBuffer.clear();
    
    for(int i = 0;i < layerBlockCounter; ++i)
        blockBuffer.push_back(totalLevelBlocks[i]);
    
    std::sort(blockBuffer.begin(), blockBuffer.end(), compareBlockID2);
    
    totalLevelBlocks.erase(totalLevelBlocks.begin(), totalLevelBlocks.begin()+layerBlockCounter);
    totalLevelBlocks.insert(totalLevelBlocks.begin(), blockBuffer.begin(), blockBuffer.end());
    
    reorderLayers();
}



void gridController::reorderLayers()
{
    //Change the rendering order of all the layers
    std::sort(totalLevelBlocks.begin(), totalLevelBlocks.end(), compareID);
    
    levelData->getRootNode()->getNode()->childNodes.clear();
    for(int i = 0; i < totalLevelBlocks.size(); ++i){
        levelData->getRootNode()->getNode()->addChildNode(totalLevelBlocks[i]->getNode());
    }
}
