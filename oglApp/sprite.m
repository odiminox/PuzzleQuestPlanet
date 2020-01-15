//
//  sprite.m
//  oglApp
//
//  Created by Simon Jordan on 10/12/2012.
//  Copyright (c) 2012 Simon Jordan. All rights reserved.
//

#import "sprite.h"

@implementation sprite

typedef struct {
    GLKVector2 posCoords;
    GLKVector2 texCoords;
} SpriteVertex;


SpriteVertex SpriteVertices[] =
{
    {{-0.5,-0.5}, {0.25f, 0.0f}},
    {{-0.5, 0.5}, {0.25f, 0.25f}},
    {{0.5,  0.5}, {0.50f, 0.25f}},
    {{0.5, -0.5}, {0.50f, 0.0f}},
};

static const GLubyte SpriteIndices[] =
{
    0, 1, 2,
    2, 3, 0
};

-(void)initialiseSpriteBuffers
{
    glGenBuffers(1, &vertexBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    
    glGenBuffers(1, &indexBufferID);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBufferID);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(SpriteIndices), SpriteIndices, GL_STATIC_DRAW);
}

-(void)initialiseSpriteAtlas:(int)imageWidth iHeight: (int)imageHeight iFWidth: (int)imageFrameWidth iFHeight:(int)imageFrameHeight cWidth:(int)cellWidth cHeight:(int)CellHeight
{
    m_imageWidth        = imageWidth;
    m_imageHeight       = imageHeight;
    m_imageFrameWidth   = imageFrameWidth;
    m_imageFrameHeight  = imageFrameHeight;
    m_cellWidth         = cellWidth;
    m_cellHeight        = CellHeight;    
}

- (void)loadSpriteTexture:(NSString *)name
{
    m_imageRef = [[UIImage imageNamed:name] CGImage];
    m_textureInfo = [GLKTextureLoader textureWithCGImage:m_imageRef options:nil error:NULL];
}

- (void)renderSprite:(GLKBaseEffect*)baseEffect
{
    //When we render our new texture, we send to GLKBaseEffect, rendering order is important.
    baseEffect.texture2d0.name   = m_textureInfo.name;
    baseEffect.texture2d0.target = m_textureInfo.target;
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(SpriteVertices), SpriteVertices, GL_STATIC_DRAW);

    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT) * 4, NULL);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GL_FLOAT) * 4, (unsigned char*)(sizeof(GL_FLOAT) * 2));
    
    //glPushMatrix();
    //glRotatef(20, 0, 0, 1);
    //glVertexPointer(2, GL_FLOAT,  sizeof(GL_FLOAT) * 4, SpriteVertices);
    
    glDrawElements(GL_TRIANGLE_STRIP, sizeof(SpriteIndices)/sizeof(SpriteIndices[0]), GL_UNSIGNED_BYTE, 0);
    
    //glPopMatrix();

    
}

- (void)translateSPrite:(float)x yPos:(float)y zPos:(float)z
{
    glTranslatef(x, y, z);
}

- (void)animateSprite:(int)numFrames sFrame: (int)startFrame eFrame: (int)endFrame deltaT: (float *)deltaTime
{
    float normWidth    =  1.0f/m_imageWidth;
    float normHeight   = 1.0f/m_imageHeight;
      
    self.timerDelay += *deltaTime;
    
    if(self.timerDelay <= -0.25f)
    {
        
        if(m_frameCounter < numFrames)
        {
            self.x++;
            m_frameCounter++;
            if(self.x==m_imageFrameWidth )
            {
                self.x=0;
                self.y++;
                if(self.y==m_imageFrameHeight)
                    self.y=0;
            }
        }else{
            m_frameCounter=0;
            self.x=0;
            self.y=0;
        }
        
        //Top left
        SpriteVertices[0].texCoords.x = ((m_cellWidth * self.x) * normWidth);
        SpriteVertices[0].texCoords.y = ((m_cellHeight * self.y) * normHeight);
        //bottom left
        SpriteVertices[1].texCoords.x = ((m_cellWidth * self.x) * normWidth);
        SpriteVertices[1].texCoords.y = ((m_cellHeight * self.y) * normHeight + (m_cellHeight * normHeight));
        //bottom right
        SpriteVertices[2].texCoords.x = ((m_cellWidth * self.x) * normWidth + (m_cellWidth * normWidth));
        SpriteVertices[2].texCoords.y = ((m_cellHeight * self.y) * normHeight + (m_cellHeight * normHeight));
        //top right
        SpriteVertices[3].texCoords.x = ((m_cellWidth * self.x) * normWidth + (m_cellWidth * normWidth));
        SpriteVertices[3].texCoords.y = ((m_cellHeight * self.y) * normHeight);
        
        self.timerDelay = 0.0f;
    }

}

@end





