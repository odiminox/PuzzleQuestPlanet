//
//  animationController.h
//  oglApp
//
//  Created by Simon Jordan on 08/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//
// The animationController class is contained within the blockPiece object and is responsible for enabling the blockPiece to animate
// and also controls the length and processing behind those animations.
// 

#ifndef oglApp_animationController_h
#define oglApp_animationController_h

#include "memoryManager.h"
#include "gameObject.h"

class gameObject;

class animationController {
public:
    animationController(gameObject* gObject);
    ~animationController();
    
    void animMoveData(float distance, float speed, float tranX, float tranY, float posModifier);
    //Movement animations are considered primary
    void animR();
    void animL();
    void animU();
    void animD();
    //These are considered secondary
    void animPopData(float upAmnt, float dwnAmnt, float upSpeed, float dwnSpeed);
    void animPop();
    void animScaleDownData(float dwnAmnt, float dwnSpeed);
    void animScaleD();
    void animScaleUpData(float upAmnt, float upSpeed);
    void animScaleU();
    
    void canRAnimPly(bool right);
    void canLAnimPly(bool left);
    void canUAnimPly(bool up);
    void canDAnimPly(bool down);
    
    void canPopAnimPly(bool pop);
    void canScaleDownAnimPly(bool scaleD);
    void canScaleUpAnimPly(bool scaleU);
    
    bool getCanRAnimPly();
    bool getCanLAnimPly();
    bool getCanUAnimPly();
    bool getCanDAnimPly();
    
    bool getCanPopAnimPly();
    bool getCanScaleDownAnimPly();
    bool getCanScaleUpAnimPly();
    
    void animGameBlk();//Used for block movement animation
    void animSecondGameBlk();//Used for secondary animations such as popping, scaling up or scaling down.
    
    void setAnimBlk(int animB);
    int getAnimBlk();
    void setSecondAnimaBlk(int anim);
    int getSecondAnimBlk();

    void initAnimData();
    
    bool getAnimPlying();
    bool getSecondAnimPlying();
    void setIsAnimPlying(bool animationPlay);
    void setIsSecondAnimPlying(bool sAnimationPlaying);
    
    void setTranslateY(float tY);
    void setTranslateX(float tX);
    void setlevelWBndsR(float num);
    void setLevelWBndsL(float num);
    void setLevelHBndsU(float num);
    void setLevelHBndsD(float num);
    
    float getTranslateX();
    float getTranslateY();
    
private:
    int animateBlock;
    int secondaryAnimateBlock;
    
    float blockOffset;
    float scaleOffset;
    
    float scaleUpAmount;
    float scaleDownAmount;
    float downSpeed;
    float upSpeed;
    
    float levelWidthBoundsRight;
    float levelWidthBoundsLeft;
    float levelHeightBoundsUp;
    float levelHeightBoundsDown;
    
    float distance;
    float speed;
    float posModifier;
    
    bool animationPlaying;
    bool secondaryAnimationPlaying;
    bool animationComplete;//Not sure if this is used anymore, might need removing
    
    bool rightAnimPlay;
    bool leftAnimPlay;
    bool upAnimPlay;
    bool downAnimPlay;
    
    bool popAnimPlay;
    bool scaleDownAnimPlay;
    bool scaleUpAnimPlay;
    
    float translateX;//Block Width and Height
    float translateY;
    //I should find a better method for manipulating the blockPiece other than this, as this class is contained within the blockPiece object...
    gameObject* _gameObject;
};

#endif
