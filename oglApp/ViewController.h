//
//  ViewController.h
//  oglApp
//
//  Created by Simon Jordan on 06/12/2012.
//  Copyright (c) 2012 Simon Jordan. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "GLKit/GLKit.h"
#include "engine.h"

class engine;

@interface ViewController : GLKViewController
{
    @private
    engine * gameEngine;
}



@end
