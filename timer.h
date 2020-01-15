//
//  timer.h
//  oglApp
//
//  Created by Simon Jordan on 03/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__timer__
#define __oglApp__timer__

#import <UIKit/UIKit.h>

class timer {
        
public:
    void timerInit();
    void timerUpdate();

    float deltaTime;
    float timerDelay;
private:
 
    float oldTimeSinceStart;
    NSDate* start;
    NSTimeInterval timeSinceStart;
    
};

#endif /* defined(__oglApp__timer__) */
