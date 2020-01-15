    //
//  fontRenderer.cpp
//  oglApp
//
//  Created by Simon Jordan on 09/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "fontRenderer.h"
/*

fontRenderer::fontRenderer()
{
      fBuffer = new spriteObject[20];
}
fontRenderer::~fontRenderer()
{
    delete []fBuffer;
    fBuffer = NULL;
}
void fontRenderer::initFontSheet()
{
    
}

void fontRenderer::loadFont(NSString* name)
{
    _fontTexture = loadTexture(name);
    
    float normWidth    =  1.0f/512.0f;
    float normHeight   = 1.0f/256.0f;
    
    float x = 0.0f;
    float y = 0.0f;
    m_frameCounter = 0;
    for(int i=0;i<54;i++){
        fontCache[i]._texture = _fontTexture;
        //Now we will increment from the first cell in the sprite sheet and run through and
        //assign the correct uvs to each font sprite
        fontCache[i].m_spriteVerts[0].texCoords[0] = ((51.0f * x) * normWidth);
        fontCache[i].m_spriteVerts[0].texCoords[1] = ((37.0f * y) * normHeight);
        fontCache[i].m_spriteVerts[1].texCoords[0] = ((51.0f * x) * normWidth);
        fontCache[i].m_spriteVerts[1].texCoords[1] = ((37.0f * y) * normHeight + (37.0f * normHeight));
        fontCache[i].m_spriteVerts[2].texCoords[0] = ((51.0f * x) * normWidth  + (51.0f * normWidth));
        fontCache[i].m_spriteVerts[2].texCoords[1] = ((37.0f * y) * normHeight + (37.0f * normHeight));
        fontCache[i].m_spriteVerts[3].texCoords[0] = ((51.0f * x) * normWidth  + (51.0f * normWidth));
        fontCache[i].m_spriteVerts[3].texCoords[1] = ((37.0f * y) * normHeight);
        
        if(m_frameCounter < 54){
            x++;
            m_frameCounter++;
            if(x==10){
                x=0;
                y++;
                if(y==6)
                    y=0;}}
    }
    
}

void fontRenderer::displayFont(spriteObject fBuffer[],int fontNum,float posx,float posy,float scalex,float scaley)
{
        fBuffer[fontNum].translateX(posx+offset);
        fBuffer[fontNum].translateY(posy);
        fBuffer[fontNum].translateZ(-5.0f);
        fBuffer[fontNum].scaleX(0.09f);
        fBuffer[fontNum].scaleY(0.09f);
        fBuffer[fontNum].scaleZ(0.09f);
        fBuffer[fontNum].rotateX(0.0f);
        fBuffer[fontNum].rotateY(0.0f);
        fBuffer[fontNum].rotateZ(0.0f);
        offset+= 2.2f;
}


void fontRenderer::printf(NSString* fontText, float fontWidth, float fontHeight, float posx, float posy)
{

     //1 Init the font buffer
    //spriteObject* fBuffer = NULL;
    //fBuffer = new spriteObject[20];
    int fontCntr = 0;
    
    //3 check the string input and assign appropriate position in font buffer from font cache
    for(int i=0;i<fontText.length;i++){        
        NSString* tempString = [fontText substringWithRange: NSMakeRange(i,1)];
        
        if([tempString isEqualToString:@"a"]){fBuffer[fontCntr]=fontCache[0];}
        if([tempString isEqualToString:@"b"]){fBuffer[fontCntr]=fontCache[1];}
        if([tempString isEqualToString:@"c"]){fBuffer[fontCntr]=fontCache[2];}
        if([tempString isEqualToString:@"d"]){fBuffer[fontCntr]=fontCache[3];}
        if([tempString isEqualToString:@"e"]){fBuffer[fontCntr]=fontCache[4];}
        if([tempString isEqualToString:@"f"]){fBuffer[fontCntr]=fontCache[5];}
        if([tempString isEqualToString:@"g"]){fBuffer[fontCntr]=fontCache[6];}
        if([tempString isEqualToString:@"h"]){fBuffer[fontCntr]=fontCache[7];}
        if([tempString isEqualToString:@"i"]){fBuffer[fontCntr]=fontCache[8];}
        if([tempString isEqualToString:@"j"]){fBuffer[fontCntr]=fontCache[9];}
        if([tempString isEqualToString:@"k"]){fBuffer[fontCntr]=fontCache[10];}
        if([tempString isEqualToString:@"l"]){fBuffer[fontCntr]=fontCache[11];}
        if([tempString isEqualToString:@"m"]){fBuffer[fontCntr]=fontCache[12];}
        if([tempString isEqualToString:@"n"]){fBuffer[fontCntr]=fontCache[13];}
        if([tempString isEqualToString:@"o"]){fBuffer[fontCntr]=fontCache[14];}
        if([tempString isEqualToString:@"p"]){fBuffer[fontCntr]=fontCache[15];}
        if([tempString isEqualToString:@"q"]){fBuffer[fontCntr]=fontCache[16];}
        if([tempString isEqualToString:@"r"]){fBuffer[fontCntr]=fontCache[17];}
        if([tempString isEqualToString:@"s"]){fBuffer[fontCntr]=fontCache[18];}
        if([tempString isEqualToString:@"t"]){fBuffer[fontCntr]=fontCache[19];}
        if([tempString isEqualToString:@"u"]){fBuffer[fontCntr]=fontCache[20];}
        if([tempString isEqualToString:@"v"]){fBuffer[fontCntr]=fontCache[21];}
        if([tempString isEqualToString:@"w"]){fBuffer[fontCntr]=fontCache[22];}
        if([tempString isEqualToString:@"x"]){fBuffer[fontCntr]=fontCache[23];}
        if([tempString isEqualToString:@"y"]){fBuffer[fontCntr]=fontCache[24];}
        if([tempString isEqualToString:@"z"]){fBuffer[fontCntr]=fontCache[25];}
        if([tempString isEqualToString:@"1"]){fBuffer[fontCntr]=fontCache[26];}
        if([tempString isEqualToString:@"2"]){fBuffer[fontCntr]=fontCache[27];}
        if([tempString isEqualToString:@"3"]){fBuffer[fontCntr]=fontCache[28];}
        if([tempString isEqualToString:@"4"]){fBuffer[fontCntr]=fontCache[29];}
        if([tempString isEqualToString:@"5"]){fBuffer[fontCntr]=fontCache[30];}
        if([tempString isEqualToString:@"6"]){fBuffer[fontCntr]=fontCache[31];}
        if([tempString isEqualToString:@"7"]){fBuffer[fontCntr]=fontCache[32];}
        if([tempString isEqualToString:@"8"]){fBuffer[fontCntr]=fontCache[33];}
        if([tempString isEqualToString:@"9"]){fBuffer[fontCntr]=fontCache[34];}
        if([tempString isEqualToString:@"0"]){fBuffer[fontCntr]=fontCache[51];}
        
        if([tempString isEqualToString:@" "]){fBuffer[fontCntr]=fontCache[53];}
        fontLen = fontCntr++;//We do this to get the amount of characters in this loop to remove from 
    }


    normWidth  = screenWidth / fontWidth;
    normHeight = screenHeight / fontHeight;
    offset = 0.0f;
    //4 display for the elements in the font buffer
    for(int i=0;i<fontCntr;i++){
        displayFont(fBuffer, i, posx, posy, 0,0);
        fontParser.push_back(&fBuffer[i]);
    }
    //5 delete the array for use in the next frame when it updates
    //delete[] fBuffer;
    //fBuffer = NULL;
}

void fontRenderer::scrubFontParser()
{
    fontParser.clear();
}

GLuint fontRenderer::loadTexture(NSString* fileName)
{
    CGImageRef texture = [UIImage imageNamed:fileName].CGImage;
    if(!texture){
        NSLog(@"Failed to load texture %@", fileName);
        exit(1);
    }
    
    size_t width = CGImageGetWidth(texture);
    size_t height = CGImageGetHeight(texture);
    
    GLubyte* textureData = (GLubyte*) calloc(width*height*4, sizeof(GLubyte));
    CGContextRef textureContext = CGBitmapContextCreate(textureData, width, height, 8, width*4,
                                                        CGImageGetColorSpace(texture), kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(textureContext, CGRectMake(0, 0, width, height), texture);
    
    CGContextRelease(textureContext);
    
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
    
    free(textureData);
    
    return texName;

}
*/