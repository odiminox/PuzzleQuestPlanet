//
//  coreType.h
//  oglApp
//
//  Created by Simon Jordan on 11/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__coreType__
#define __oglApp__coreType__

#include "OBJECT.h"
#include <vector>

class coreType {
    
public:
    static std::vector<OBJECT*> SceneObjects;
};

coreType* CORETYPE = new coreType();

#endif /* defined(__oglApp__coreType__) */
