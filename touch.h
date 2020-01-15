
#pragma  once
//#include "../globals.h"
//#include <GL/glew.h>
#include <iostream>
#include <sstream>
#import <UIKit/UIKit.h>
//#include <Windows.h>
#include <string>
#include "camera.h"

class touch
{
public:

	touch(CGPoint* touchPosition, bool* touchHeld, bool* isTouched);
	~touch();
	

	void updateMouse(float width, float height, camera* viewportCamera);
	void checkForMovement();
    void getOldMousePos();

	float getScreenX();
	float getScreenY();

	float getWorldX();
	float getWorldY();
	float getWorldZ();

	std::string ScreenXString();
	std::string ScreenYString();

	std::string WorldXString();
	std::string WorldYString();
	std::string WorldZString();

	void unProjectMouse(float width, float height, camera* viewportCamera);
    
    CGPoint getPoint();
    
    bool getTouchHeld();
    
    void updateIsTouched(bool *isTouched);
    
    void printTouch();

private:
	bool Lup;
	bool Ldown;

	bool Rup;
	bool Rdown;

	float mouseX;
	float mouseY;

	float mouseWorldX;
	float mouseWorldY;
	float mouseWorldZ;

	bool mouseMoved;
    
    bool* touchHeld;
    bool* isTouched;

	CGPoint* mPoint;
	CGPoint oldPoint;
};