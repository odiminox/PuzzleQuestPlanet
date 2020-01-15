//
//  testClass.cpp
//  oglApp
//
//  Created by Simon Jordan on 03/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "testClass.h"

testClass::testClass()
{
    testFloat = 5.0f;
    testInt   = 5;
}
testClass::~testClass()
{
    testFloat = 0.0f;
    testInt   = 0;
}

void testClass::testMeth()
{
    testFloat += 15.0f;
    testInt   += 15;
}

void testClass::setFloat(float inFloat)
{
    testFloat = inFloat;
}

void testClass::setInt(int inInt)
{
    testInt = inInt;
}

float testClass::getFloat()
{
    return testFloat;
}

int testClass::getInt()
{
    return testInt;
}