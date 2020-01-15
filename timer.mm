//
//  timer.cpp
//  oglApp
//
//  Created by Simon Jordan on 03/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "timer.h"

void timer::timerUpdate()
{
    timeSinceStart = [start timeIntervalSinceNow];
    
    deltaTime = timeSinceStart - oldTimeSinceStart;
    oldTimeSinceStart = timeSinceStart;
    
    timerDelay += deltaTime;
    //NSLog(@"%f", timerDelay);
}

void timer::timerInit()
{
     start = [NSDate date];
}