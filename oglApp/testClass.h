//
//  testClass.h
//  oglApp
//
//  Created by Simon Jordan on 03/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__testClass__
#define __oglApp__testClass__

#include <iostream>

class testClass {
    
public:
    float testFloat;
    int testInt;
    
    testClass();
    ~testClass();

    void testMeth();
    void secondTestMeth();
    void setFloat(float);
    void setInt(int);
    float getFloat();
    int getInt();
    
};

#endif /* defined(__oglApp__testClass__) */
