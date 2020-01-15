//
//  camera.h
//  oglApp
//
//  Created by Simon Jordan on 04/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__camera__
#define __oglApp__camera__

#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"

class camera {
   
public:
    camera();
    ~camera();
        
    void pitchCamera(float angle);
    void rollCamera(float angle);
    void yawCamera(float angle);
    void setCamPitchYawRoll(float pitch,float yaw,float roll);
    void offSetCamPitchRoll(float pitch, float yaw, float roll);
    
    float getCameraPitch();
    float getCameraRoll();
    float getCameraYaw();
    
    void translateCameraX(float amount);
    void translateCameraY(float amount);
    void translateCameraZ(float amount);
    void translateCamera(float x, float y, float z);
    
    void offsetCameraX(float amount);
    void offsetCameraY(float amount);
    void offsetCameraZ(float amount);
    void offsetCamera(float x, float y, float z);
    
    float getCameraPosX();
    float getCameraPosY();
    float getCameraPosZ();
    
    float getCamNearPlane();
    float getCamFarPlane();
    
    void setCamPosition(glm::vec3& position);
    void offsetCamPosition(const glm::vec3& offset);
    glm::vec3& getCamPosition();
    
    glm::mat4 updateProjection();
    glm::mat4 updateProjectionOrtho();
    glm::mat4 updateView();
    
    glm::mat4 camOrientation();
    
    glm::vec3 getForward();
    glm::vec3 getUp();
    glm::vec3 getRight();
    
    void setAspectRatio(float amount);
    float getAspectRatio();
    
private:
    glm::vec3 m_cameraPosition;
    glm::vec3 m_cameraTarget;
    glm::vec3 m_upVector;  
    float     m_pitch;
    float     m_roll;
    float     m_yaw;
    float     m_fieldOfView;
    float     m_nearPlane;
    float     m_farPlane;
    float     m_aspectRatio;
};

#endif /* defined(__oglApp__camera__) */
