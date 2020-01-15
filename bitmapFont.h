//
//  bitmapFont.h
//  oglApp
//
//  Created by SimonJordan on 06/04/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef oglApp_bitmapFont_h
#define oglApp_bitmapFont_h

#include "NODEUI.h"


struct font {
    NODEUI* fontNode;
    MESH2D* fontMesh;
};

class bitmapFont {
    
public:
    void initFontData();
    void loadFont(std::string fontTexture);
    void printf(std::string fontText, float x, float y);
    
private:
    font* fBuffer;
    font fontCache[54];
    
    float offset;
    
    float normWidth;
    float normHeight;
    float screenWidth;
    float screenHeight;
    
    int charNum;
    int frameCounter;
    
    GLuint _fontTexture;

};

#endif
