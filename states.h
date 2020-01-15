//
//  states.h
//  oglApp
//
//  Created by SimonJordan on 01/04/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef oglApp_states_h
#define oglApp_states_h




class states {
    
    
public:
    states();
    ~states();
    
    enum gameStates { menuState, loadingState, inGameState, pauseState, quittingState };
    
    gameStates mCurrentState;
    gameStates mSelectedState;
    
    gameStates getCurrentState();
    void setCurrentGameState(gameStates current);
    
    
};

#endif
