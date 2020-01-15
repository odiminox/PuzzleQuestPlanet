//
//  sprite.h
//  oglApp
//
//  Created by Simon Jordan on 10/12/2012.
//  Copyright (c) 2012 Simon Jordan. All rights reserved.
//

//#import <UIKit/UIKit.h>
#include "GLKit/GLKit.h"

@interface sprite : EAGLContext


-(void)initialiseSpriteAtlas:(int)imageWidth iHeight: (int)imageHeight iFWidth: (int)imageFrameWidth iFHeight:(int)imageFrameHeight cWidth:(int)cellWidth cHeight:(int)CellHeight;
- (void)animateSprite:(int)numFrames sFrame: (int)startFrame eFrame: (int)endFrame deltaT: (float *)deltaTime;
- (void)loadSpriteTexture:(NSString *)name;
- (void)renderSprite:(GLKBaseEffect*)baseEffect;
- (void)initialiseSpriteBuffers;
- (void)translateSPrite:(float)x yPos: (float)y zPos: (float)z;

@property (nonatomic, assign)int x;
@property (nonatomic, assign)int y;

@property (nonatomic, assign)float timerDelay;


@end

CGImageRef m_imageRef;
GLKTextureInfo * m_textureInfo;
GLKBaseEffect* spriteEffect;
GLuint vertexBufferID;
GLuint indexBufferID;

int m_imageWidth;
int m_imageHeight;
int m_imageFrameWidth;
int m_imageFrameHeight;
int m_cellWidth;
int m_cellHeight;
int m_frameCounter;




