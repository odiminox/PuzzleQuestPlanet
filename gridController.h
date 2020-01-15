//
//  gridController.h
//  oglApp
//
//  Created by Simon Jordan on 16/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
//  This class is responsible for the user interacting with blocks in the grid and also how those blocks interact with each other
//  An example might be the user swiping a block, then checking for neighbour blocks, or a block checking for matches in a row
//

#ifndef oglApp_gridController_h
#define oglApp_gridController_h

#include <vector>
#include "blockPiece.h"
#include "levelDataController.h"
#include "memoryManager.h"

inline bool compareID(blockPiece *a, blockPiece *b)
{
    return (a->getNode()->getRenderOrderID() > b->getNode()->getRenderOrderID());
};

inline bool compareBlockID(blockPiece *a, blockPiece *b)
{
    return (a->getNode()->getBlockRenderOrderID() > b->getNode()->getBlockRenderOrderID());
};

inline bool compareBlockID2(blockPiece *a, blockPiece *b)
{
    return (a->getNode()->getBlockRenderOrderID() < b->getNode()->getBlockRenderOrderID());
};


class gridController {
    
public:
    gridController();
    ~gridController();
    
    void calcLevelCol();
    void chkBlockCol(int blockNum);
    
    void chkSwipeLAnim(int blockTouched, int neighbourIndex);
    void chkSwipeRAnim(int blockTouched, int neighbourIndex);
    void chkSwipeUAnim(int blockTouched, int neighbourIndex);
    void chkSwipeDAnim(int blockTouched, int neighbourIndex);
    
    void chk4NeighbBlocks();
    void chk3NeighbBlocks();
    void chk2NeighbBlocks();
    
    void detLSClicked();
    void detRSClicked();
    void detTClicked();
    void detBClicked();
    
    void detTLClicked();
    void detTRClicked();
    void detBLClicked();
    void detBRClicked();
    
    void reorderBlocks();
    void sortBlocks();
    void sortBlocks(std::vector<blockPiece*> vecToSort, int numToSort);
    void reorderLayers(std::vector<blockPiece*> vecToSort);
    void reorderBlocksSort();
    void reorderLayers();
    
    bool detIfMatchRemove(int blockToCheck, int blockTouched);

    std::vector<int> calNieghbBlocks(int blockNumber);
    
    void procBlockAnims(bool testCondition, int touchedBlock, int otherBlock);
    
    void checkHorizontalLineLeft(int blockA, int blockB);
    void checkHorizontalLineRight(int blockA,int blockB);
    void checkVerticleLineUp(int blockA, int blockB);
    void checkVerticleLineDown(int blockA, int blockB);
    
    levelDataController* getLevelData();
    
    void setLBC(int counter);
    int getLBC();
    
    void addToLPieceVec(blockPiece* blkPiece);
    void addToBlkBfferVec(blockPiece* blkPiece);
    
    std::vector<blockPiece*> getLPieces();
    std::vector<blockPiece*> getBBuffer();
    std::vector<blockPiece*> getTotLBlocks();
    std::vector<int> getBlockNeighbBuffer();
    
    blockPiece* getLPieceAt(int index);
    blockPiece* getBBAt(int index);
    blockPiece* getLBFromTotalAt(int index);
    int getBlockNeighbBufferAt(int index);
    
    void assignLevelPiecesToVec(std::vector<blockPiece*> vec);
    void assignBlockBufferToVec(std::vector<blockPiece*> vec);
    void assignTotalLevelBlocksToVec(std::vector<blockPiece*> vec);
    void assignBlockNeighbourBufferToVec(std::vector<int> vec);
    
    int getBlocNumTouch();
    void setBlockNumberTouched(int num);
    int getBlockAnimIndex();
    void setBlockAnimIndex(int num);
    
    void setSavedSwipeAction(int num);
    int getSavedSwipeAction();
    
    void setSvdBlkAnim(int num);
    int getSvdBlkAnim();
    void setSvdBlkTouch(int num);
    int getSvdBlkTouch();
    
    void setBlkSlktd(bool blkslktd);
    bool getBlkSlktd();

    bool getAreNodesDirty();
    void setAreNodesDirty(bool nodes);
    
    void setLockInput(bool input);
    bool getLockInput();
    
    bool checkForPendingSecondaryAnims();
    
    void updateBlockPrimaryAnims();
    void updateBlockSecondaryAnims();
    
private:
    bool rightAnim;
    bool leftAnim;
    bool upAnim;
    bool downAnim;
    
    bool dirtyNodes;
    
    float blockWidth;
    float blockHeight;
    
    int savedSwipeAction;//[0,1,2,3] <-> [LEFT, RIGHT, UP, DOWN]
    
    int layerBlockCounter;//gridx*gridy
    
    std::vector<int> blockNeighbourBuffer;//Needs renaming, the block neighbour buffer
    std::vector<blockPiece*> totalLevelBlocks;//holds all the blocks in the gameLevel
    std::vector<blockPiece*> blockBuffer;
    std::vector<blockPiece*> levelPieces;
    
    std::vector<int> blocksToCheck;
    std::vector<int> blocksToRemove;
    std::vector<int> horizontalMatches;
    std::vector<int> verticleMatches;
    
    std::vector<blockPiece*> verticleBlocksToAdd;
    std::vector<blockPiece*> horizontalBlocksToAdd;
    
    std::vector<blockPiece*> blocksToAnimate;
    
    int savedBlockAnim;
    int savedBlockTouched;
    
    int blockNumberTouched;
    int blockAnimIndex;//The other block to animate that we are swiping towards
    
    bool reverseAnimation;
    bool checkToReverse;
    bool blockSelected;
    
    bool lockInput;
    bool pendingAnims;
    
    levelDataController* levelData;
};

#endif
