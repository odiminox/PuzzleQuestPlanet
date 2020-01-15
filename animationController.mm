//
//  animationController.cpp
//  oglApp
//
//  Created by Simon Jordan on 09/05/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "animationController.h"

animationController::animationController(gameObject* gObject)
{
    this->_gameObject = gObject;
    animateBlock = -1;
    blockOffset = 0.0f;
    animationPlaying = false;
    secondaryAnimationPlaying = false;
}

animationController::~animationController()
{
}


void animationController::initAnimData()
{


}

void animationController::setTranslateY(float tY)
{
    translateY = tY;
}
void animationController::setTranslateX(float tX)
{
    translateX = tX;
}

float animationController::getTranslateX()
{
    return translateX;
}
float animationController::getTranslateY()
{
    return translateY;
}
void animationController::setlevelWBndsR(float num)
{
    levelWidthBoundsRight = num;
}
void animationController::setLevelWBndsL(float num)
{
    levelWidthBoundsLeft = num;
}
void animationController::setLevelHBndsU(float num)
{
    levelHeightBoundsUp = num;
}
void animationController::setLevelHBndsD(float num)
{
    levelHeightBoundsDown = num;
}

void animationController::setIsAnimPlying(bool animationPlay)
{
    animationPlaying = animationPlay;
}
void animationController::setIsSecondAnimPlying(bool sAnimationPlaying)
{
    secondaryAnimationPlaying = sAnimationPlaying;
}

void animationController::animMoveData(float distance, float speed, float tranX, float tranY, float posModifier)
{
    this->distance = distance;
    this->speed = speed;
    this->posModifier = posModifier;
    translateX = tranX;
    translateY = tranY;
    
}

//These functions are very immobile and tied to this game. I could modify them with variables to allow them to animate any sized block, any distance to any speed
//These functions would be the data processing functions that act on the data, so we would need an external function to take in the appropriate data
void animationController::animR()
{
    blockOffset += distance * speed;//Distance * speed
    animationPlaying = true;//Only one movement animation per block can play at a time

    if(_gameObject->getNode()->getPosX() >= _gameObject->getHomePos().x + translateX - posModifier){//See if its accumulated distance is greater than or equal to the home pos plus the desired target amount
        blockOffset = 0.0f;
        animationPlaying = false;
        animateBlock = -1;
    }
    
    if( _gameObject->getNode()->getPosX() <= _gameObject->getHomePos().x + translateX - posModifier)//If we still haven't encountered our destination, keep moving
        _gameObject->getNode()->offsetX(blockOffset);
}
void animationController::animL()
{
    blockOffset -= distance * speed;
    animationPlaying = true;

    if(_gameObject->getNode()->getPosX() <= _gameObject->getHomePos().x - translateX - posModifier){
        animationPlaying = false;
        blockOffset = 0.0f;
        animateBlock = -1;
    }
    
    if( _gameObject->getNode()->getPosX() >= _gameObject->getHomePos().x - translateX - posModifier)
        _gameObject->getNode()->offsetX(blockOffset);
}
void animationController::animU()
{
    blockOffset += distance * speed;
    animationPlaying = true;

    if(_gameObject->getNode()->getPosY() >= _gameObject->getHomePos().y + (translateY - posModifier)){//Need to add a normalised width and height of the object to translate it by, instead of the fixed figure
        animationPlaying = false;                                                                 //so it can work on any 2D object
        blockOffset = 0.0f;                                                                       //If the object is rectangular, it will need this modifier, so a base value must be applied to each block
        animateBlock = -1;
    }
    if( _gameObject->getNode()->getPosY() <= _gameObject->getHomePos().y + (translateY - posModifier))
        _gameObject->getNode()->offsetY(blockOffset);
}
void animationController::animD()
{
    blockOffset -= distance * speed;
    animationPlaying = true;

    if(_gameObject->getNode()->getPosY() <= _gameObject->getHomePos().y - (translateY - posModifier)){
        animationPlaying = false;
        blockOffset = 0.0f;
        animateBlock = -1;
    }
    if( _gameObject->getNode()->getPosY() >= _gameObject->getHomePos().y - (translateY - posModifier))
        _gameObject->getNode()->offsetY(blockOffset);
}

void animationController::animGameBlk()
{
        switch (animateBlock) {
            case 0:
                animR();
                break;
            case 1:
                animL();
                break;
            case 2:
                animU();
                break;
            case 3:
                animD();
            default:
                break;
        }    
}

void animationController::animPopData(float upAmnt, float dwnAmnt, float upSpeed, float dwnSpeed)
{
    this->upSpeed = upSpeed;
    downSpeed = dwnSpeed;
    animScaleDownData(dwnAmnt, dwnSpeed);
    animScaleUpData(upAmnt, upSpeed);
}
void animationController::animPop()
{
    //Popping animations lazily put together, works by scaling up then scaling down
    animScaleU();
    if(scaleUpAmount == 0.0f)
        animScaleD();
}
void animationController::animScaleDownData(float dwnAmnt, float dwnSpeed)
{
    scaleDownAmount = dwnAmnt;
    downSpeed = dwnSpeed;
}
void animationController::animScaleD()
{
    scaleDownAmount -= downSpeed;
    secondaryAnimationPlaying = true;
    
    //We want it to uniformally scale down, not all hapes are uniform, so we have to do it based off of the first to fail
    if(_gameObject->getNode()->getScaleX() <= scaleDownAmount || _gameObject->getNode()->getScaleY() <= scaleDownAmount){
        secondaryAnimationPlaying = false;
        scaleDownAmount = 0.0f;
        secondaryAnimateBlock = -1;
    }
    if(_gameObject->getNode()->getScaleX() >= scaleDownAmount || _gameObject->getNode()->getScaleY() >= scaleDownAmount){
        _gameObject->getNode()->offsetScaleX(scaleDownAmount);
        _gameObject->getNode()->offsetScaleY(scaleDownAmount);
    }
}
void animationController::animScaleUpData(float upAmnt, float upSpeed)
{
    scaleUpAmount = upAmnt;
    this->upSpeed = upSpeed;
}
void animationController::animScaleU()
{
    scaleUpAmount += upSpeed;
    secondaryAnimationPlaying = true;
    
    //We want it to uniformally scale down, not all hapes are uniform, so we have to do it based off of the first to fail
    if(_gameObject->getNode()->getScaleX() >= scaleUpAmount || _gameObject->getNode()->getScaleY() >= scaleUpAmount){
        secondaryAnimationPlaying = false;
        scaleUpAmount = 0.0f;
        secondaryAnimateBlock = -1;
    }
    if(_gameObject->getNode()->getScaleX() <= scaleUpAmount || _gameObject->getNode()->getScaleY() <= scaleUpAmount){
        _gameObject->getNode()->offsetScaleX(scaleUpAmount);
        _gameObject->getNode()->offsetScaleY(scaleUpAmount);
    }

}
void animationController::animSecondGameBlk()
{
    
    switch (secondaryAnimateBlock) {
        case 0:
            animPop();
            break;
        case 1:
            animScaleU();
            break;
        case 2:
            animScaleD();
            break;
        default:
            break;
    }
     
}

bool animationController::getAnimPlying()
{
    return animationPlaying;
}

bool animationController::getSecondAnimPlying()
{
    return secondaryAnimationPlaying;
}

void animationController::canRAnimPly(bool right)
{
    rightAnimPlay = right;
}
void animationController::canLAnimPly(bool left)
{
    leftAnimPlay = left;
}
void animationController::canUAnimPly(bool up)
{
    upAnimPlay = up;
}
void animationController::canDAnimPly(bool down)
{
    downAnimPlay = down;
}

void animationController::canPopAnimPly(bool pop)
{
    popAnimPlay = pop;
}

void animationController::canScaleUpAnimPly(bool scaleU)
{
    scaleUpAnimPlay = scaleU;
}

void animationController::canScaleDownAnimPly(bool scaleD)
{
    scaleDownAnimPlay = scaleD;
}

bool animationController::getCanRAnimPly()
{
    return rightAnimPlay;
}
bool animationController::getCanLAnimPly()
{
    return leftAnimPlay;
}
bool animationController::getCanUAnimPly()
{
    return upAnimPlay;
}
bool animationController::getCanDAnimPly()
{
    return downAnimPlay;
}

bool animationController::getCanPopAnimPly()
{
    return popAnimPlay;
}
bool animationController::getCanScaleUpAnimPly()
{
    return scaleUpAnimPlay;
}
bool animationController::getCanScaleDownAnimPly()
{
    return scaleDownAnimPlay;
}

void animationController::setAnimBlk(int animB)
{
    animateBlock = animB;
    animationPlaying = true;
}
int animationController::getAnimBlk()
{
    return animateBlock;
}
void animationController::setSecondAnimaBlk(int anim)
{
    secondaryAnimateBlock = anim;
    secondaryAnimationPlaying = true;
}
int animationController::getSecondAnimBlk()
{
    return secondaryAnimateBlock;
}

