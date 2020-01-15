//
//  renderer.h
//  oglApp
//
//  Created by Simon Jordan on 05/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__renderer__
#define __oglApp__renderer__

#include "shaderLoader.h"
//#include "OBJECT.h"
//#include "spriteObject.h"
#include "memoryManager.h"
//#include "nodePath.h"

#include "glm/glm.hpp"
#include "glm/gtc/matrix_transform.hpp"
#include <vector>


class renderer {
    
    
public:
    shaderLoader* shader;
    
    //std::vector<OBJECT*> SceneObjects;
    //std::vector<OBJECT*> dynamicObjects;
    //std::vector<OBJECT*> cacheObjects;
    
    //std::vector<NODE*> sceneNodes;
    
    renderer();
    ~renderer();
    void drawRender(float *deltaTime);
    //void drawRendererNodes(glm::mat4 &view, glm::mat4 &projection, float *deltaTime);
    //void drawScene(glm::mat4 &view, glm::mat4 &projection, float *deltaTime, NODE* rootNode);
    
    
    void updateRenderObjs();
    void updateRendererNodes(float delta);
    
    void initRendererGfx();
    void initDynamicObjs();
    void initRendererObjs();
    void initRendererNodes();
    
    //void parseObjects(std::vector<OBJECT*>Objs);
    
    GLuint _texCoordSlot;
    GLuint _positionSlot;
    GLuint _colorSlot;
    
    glm::mat4 view;
    glm::mat4 projection;
    
    float delta;
    
};

#endif /* defined(__oglApp__renderer__) */
