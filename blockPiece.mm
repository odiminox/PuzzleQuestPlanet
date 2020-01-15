//
//  blockPiece.cpp
//  oglApp
//
//  Created by SimonJordan on 02/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "blockPiece.h"

blockPiece::blockPiece()
{
    isBlockTouched = false;
    isAtHome = true;
}
blockPiece::~blockPiece()
{
    
}


void blockPiece::setBlockedTouched(bool touched)
{
    isBlockTouched = touched;
}

bool blockPiece::getIsBlockTouched()
{
    return isBlockTouched;
}

void blockPiece::setHomePosXY(float x, float y)
{
    homePos.x = x;
    homePos.y = y;
}

void blockPiece::setBlockType(int blockType)
{
    this->blockType = blockType;
}
int blockPiece::getBlockType() const
{
    return blockType;
}

void blockPiece::setBlockGridXY(int x, int y)
{
    blockGridX = x;
    blockGridY = y;
}
int blockPiece::getGridBlockX() const
{
    return blockGridX;
}
int blockPiece::getGridBlockY() const
{
    return blockGridY;
}


