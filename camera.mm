//
//  camera.cpp
//  oglApp
//
//  Created by Simon Jordan on 04/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "camera.h"

camera::camera()
{
    m_cameraPosition  = glm::vec3(0.0f,0.0f,0.0f);
    m_cameraTarget    = glm::vec3(0.0f, 0.0f, 0.0f);
    m_upVector        = glm::vec3(0.0f, 1.0f, 0.0f);
    m_pitch           = 0.0f;
    m_roll            = 0.0f;
    m_yaw             = 0.0f;
    m_fieldOfView     = 45.0f;
    m_nearPlane       = 0.1f;
    m_farPlane        = 100.0f;
    m_aspectRatio     = 4.0f/3.0f;
    
}
camera::~camera()
{
    
}

void camera::setCamPosition(glm::vec3& position){m_cameraPosition = position;}
void camera::offsetCamPosition(const glm::vec3& offset){m_cameraPosition += offset;}
glm::vec3& camera::getCamPosition(){return m_cameraPosition;}

void camera::translateCamera(float x, float y, float z)
{
    m_cameraPosition.x = x;
    m_cameraPosition.y = y;
    m_cameraPosition.z = z;
}

void camera::translateCameraX(float amount){m_cameraPosition.x = amount;}
void camera::translateCameraY(float amount){m_cameraPosition.y = amount;}
void camera::translateCameraZ(float amount){m_cameraPosition.z = amount;}

void camera::offsetCameraX(float amount){m_cameraPosition.x += amount;}
void camera::offsetCameraY(float amount){m_cameraPosition.y += amount;}
void camera::offsetCameraZ(float amount){m_cameraPosition.z += amount;}
void camera::offsetCamera(float x, float y, float z)
{
    m_cameraPosition.x += x;
    m_cameraPosition.y += y;
    m_cameraPosition.z += z;
}

float camera::getCamFarPlane(){return m_farPlane;}
float camera::getCamNearPlane(){return m_nearPlane;}

glm::mat4 camera::camOrientation()
{
    glm::mat4 orientation;
    orientation = glm::rotate(orientation, m_pitch, glm::vec3(1,0,0));
    orientation = glm::rotate(orientation, m_yaw,   glm::vec3(0,1,0));
    orientation = glm::rotate(orientation, m_roll,  glm::vec3(0,0,1));
    return orientation;
}

void  camera::pitchCamera(float angle){m_pitch = angle;}
void  camera::yawCamera  (float angle){m_yaw   = angle;}
void  camera::rollCamera (float angle){m_roll  = angle;}
float camera::getCameraPitch(){return m_pitch;}
float camera::getCameraYaw()  {return m_yaw;}
float camera::getCameraRoll() {return m_roll;}

float camera::getCameraPosX()
{
    return m_cameraPosition.x;
}

float camera::getCameraPosY()
{
    return m_cameraPosition.y;
}
float camera::getCameraPosZ()
{
    return m_cameraPosition.z;
}

void  camera::setCamPitchYawRoll(float pitch, float yaw, float roll)
{
    m_pitch = pitch;
    m_yaw   = yaw;
    m_roll  = roll;
}

void camera::offSetCamPitchRoll(float pitch, float yaw, float roll)
{
    m_pitch += pitch;
    m_yaw   += yaw;
    m_roll  += roll;
}

void camera::setAspectRatio(float amount){m_aspectRatio = amount;}
float camera::getAspectRatio(){return m_aspectRatio;}

glm::vec3 camera::getForward()
{
    glm::vec4 forward = glm::inverse(camOrientation())  * glm::vec4(0,0,-1,1);
    return glm::vec3(forward);
}
glm::vec3 camera::getRight()
{
    glm::vec4 right = glm::inverse(camOrientation()) * glm::vec4(1,0,0,1);
    return glm::vec3(right);
}
glm::vec3 camera::getUp()
{
    glm::vec4 up = glm::inverse(camOrientation())  * glm::vec4(0,1,0,1);
    return glm::vec3(up);
}

glm::mat4 camera::updateProjectionOrtho()
{
    return glm::ortho( 0.0f, 400.0f, 300.0f, 0.0f,-5.0f, 5.0f);
}

glm::mat4 camera::updateProjection(){return glm::perspective(m_fieldOfView, m_aspectRatio, m_nearPlane, m_farPlane);}
glm::mat4 camera::updateView(){return camOrientation() * glm::translate(glm::mat4(), -m_cameraPosition);}

