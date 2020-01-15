//
//  bitmapFont.cpp
//  oglApp
//
//  Created by SimonJordan on 06/04/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "bitmapFont.h"

void bitmapFont::loadFont(std::string fontTexture)
{
    float normWidth    =  1.0f/512.0f;
    float normHeight   = 1.0f/256.0f;
    
    float x = 0.0f;
    float y = 0.0f;
    frameCounter = 0;
         /*
    for(int i=0;i<54;i++){
        
        fontCache[i].fontMesh = new MESH2D();
        fontCache[i].fontMesh->loadTexture(fontTexture);
        fontCache[i].fontNode = new NODEUI(fontCache[i].fontMesh);
        
        //fontCache[i]._texture = _fontTexture;
        //Now we will increment from the first cell in the sprite sheet and run through and
        //assign the correct uvs to each font sprite
   
        fontCache[i].fontMesh->testVerts2D[0].texCoords[0] = ((51.0f * x) * normWidth);
        fontCache[i].testVerts2D[0].texCoords[1] = ((37.0f * y) * normHeight);
        fontCache[i].testVerts2D[1].texCoords[0] = ((51.0f * x) * normWidth);
        fontCache[i].testVerts2D[1].texCoords[1] = ((37.0f * y) * normHeight + (37.0f * normHeight));
        fontCache[i].testVerts2D[2].texCoords[0] = ((51.0f * x) * normWidth  + (51.0f * normWidth));
        fontCache[i].testVerts2D[2].texCoords[1] = ((37.0f * y) * normHeight + (37.0f * normHeight));
        fontCache[i].testVerts2D[3].texCoords[0] = ((51.0f * x) * normWidth  + (51.0f * normWidth));
        fontCache[i].testVerts2D[3].texCoords[1] = ((37.0f * y) * normHeight);
        
        if(frameCounter < 54){
            x++;
            m_frameCounter++;
            if(x==10){
                x=0;
                y++;
                if(y==6)
                    y=0;}}
*/
}