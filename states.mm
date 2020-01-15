//
//  states.cpp
//  oglApp
//
//  Created by SimonJordan on 01/04/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "states.h"

states::states()
{
    mCurrentState = menuState;

}
states::~states()
{
}

void states::setCurrentGameState(states::gameStates current)
{
    mCurrentState = current;
}

states::gameStates states::getCurrentState()
{
    return mCurrentState;
}