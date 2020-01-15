//
//  blockPiece.h
//  oglApp
//
//  Created by SimonJordan on 02/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
// The blockPiece is the core object which contibutes towards the level grid and is the primary focus of which the player will interact with
//

#ifndef oglApp_blockPiece_h
#define oglApp_blockPiece_h
#include "memoryManager.h"
#include "gameObject.h"


class blockPiece:public gameObject {
public:
    blockPiece();
    ~blockPiece();
    
    bool isAtHomeSquare();
    void setHomePosXY(float x, float y);
    
    void setBlockedTouched(bool touched);
    bool getIsBlockTouched();
    
    void setBlockType(int blockType);
    int getBlockType() const;
    
    void setBlockGridXY(int x, int y);
    int getGridBlockX() const;
    int getGridBlockY() const;
            

private:
    
    int blockGridX;
    int blockGridY;
    
    bool isAtHome;
    
    bool isBlockTouched;
    
    int blockType;
};



#endif
