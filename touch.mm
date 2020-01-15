#include "touch.h"

touch::touch(CGPoint* touchPosition, bool* touchHeld, bool* isTouched):mouseMoved(false)
{
	if(NULL == touchPosition){
		NSLog(@"CGPoint invalid!");
	}
	{
		mPoint = touchPosition;
        this->touchHeld = touchHeld;
        this->isTouched = isTouched;
	}
	
}

touch::~touch()
{

}

bool touch::getTouchHeld()
{
    return touchHeld;
}

void touch::printTouch()
{
    NSLog(@"TOUCHED: %d",(int)*isTouched);
}

void touch::updateIsTouched(bool *isTouched)
{
    this->isTouched = isTouched;
}

void touch::unProjectMouse(float width, float height, camera* viewportCamera)
{
	if(NULL == viewportCamera)
	{
		NSLog(@"camera failed! failed to un-project mouse");
	} else {

		glm::vec4 viewport = glm::vec4(0.0f, 0.0f, width, height);
		glm::mat4 tmpView = glm::lookAt(glm::vec3(viewportCamera->getCameraPosX(),viewportCamera->getCameraPosY(),viewportCamera->getCameraPosZ()),
										glm::vec3(viewportCamera->getForward().x,viewportCamera->getForward().y,viewportCamera->getForward().z),glm::vec3(0,1,0));
		glm::mat4 tmpProj = glm::perspective( 90.0f, width/height, 0.1f, 1000.0f);
		glm::vec3 screenPos = glm::vec3(mouseX, height-mouseY - 1, 0.0f);

		glm::vec3 worldPos = glm::unProject(screenPos, tmpView, tmpProj, viewport);
        
		mouseWorldX = worldPos.x;
		mouseWorldY = worldPos.y;
		mouseWorldZ = worldPos.z;
	}
	
}
std::string touch::ScreenXString()
{
	std::stringstream ss (std::stringstream::in | std::stringstream::out);
	ss << mPoint->x;
	return ss.str();
}
std::string touch::ScreenYString()
{
	std::stringstream ss (std::stringstream::in | std::stringstream::out);
	ss << mPoint->y;
	return ss.str();
}

std::string touch::WorldXString()
{
	std::stringstream ss (std::stringstream::in | std::stringstream::out);
	ss << mouseWorldX;
	return ss.str();
}
std::string touch::WorldYString()
{
	std::stringstream ss (std::stringstream::in | std::stringstream::out);
	ss << mouseWorldY;
	return ss.str();
}
std::string touch::WorldZString()
{
	std::stringstream ss (std::stringstream::in | std::stringstream::out);
	ss << mouseWorldZ;
	return ss.str();
}


void touch::updateMouse(float width, float height, camera* viewportCamera)
{
	
	//If movement, the mouse moved, so update the mouse. Otherwise skip
	//and mouse data stays the same. Should save some mat4 and vec3 calls
	//from unProjectMouse()
	if(mouseMoved){
        
       //NSLog(@"Unproject Mouse X: %f", mouseWorldX);
        //NSLog(@"Unproject Mouse Y: %f", mouseWorldY);
        
		mouseMoved = false;

		unProjectMouse(width, height, viewportCamera);
	}

}

CGPoint touch::getPoint()
{
    return *mPoint;
}

void touch::getOldMousePos()
{
    //First get the position of the mouse and assign it to oldPoint
	oldPoint.x = mPoint->x;
	oldPoint.y = mPoint->y;
    mouseX = mPoint->x;
    mouseY = mPoint->y;
    
}

void touch::checkForMovement()
{
	
	if(oldPoint.x != mPoint->x  ||oldPoint.y !=  mPoint->y)
	{
		mouseMoved = true;
	} else {
		mouseMoved = false;
	}
}

float touch::getScreenX(){return mouseX;}
float touch::getScreenY(){return mouseY;}
float touch::getWorldX(){return mouseWorldX;}
float touch::getWorldY(){return mouseWorldY;}
float touch::getWorldZ(){return mouseWorldZ;}
