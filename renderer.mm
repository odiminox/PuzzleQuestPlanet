//
//  renderer.cpp
//  oglApp
//
//  Created by Simon Jordan on 05/02/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "renderer.h"

renderer::renderer()
{
    shader = new shaderLoader();
}

renderer::~renderer()
{
    safeDelete(shader);
    /*
     for(int i = 0; i<sceneNodes.size(); ++i){
     safeDelete(sceneNodes[i]);
     }
     */
    
}

void renderer::initRendererGfx()
{
    shader->compilerShaders();
    
}


void renderer::initRendererNodes()
{
    /*
     for(int i=0;i<sceneNodes.size();i++){
     if(sceneNodes.size()>0){
     sceneNodes[i]->init();
     }
     }*/
    
    /*
     for(int i=0; i<sceneNodes.size();i++)
     {
     sceneNodes[i]->meshNode->initBuffers();
     sceneNodes[i]->meshNode->visible(true);
     
     if(sceneNodes.size()>0){
     for(int i =0; i <sceneNodes[i]->childNodes.size();i++)
     {
     sceneNodes[i]->childNodes[i]->meshNode->initBuffers();
     sceneNodes[i]->childNodes[i]->meshNode->visible(true);
     }
     
     }
     }
     */
}

void renderer::updateRendererNodes(float delta)
{
    /*
     for(int i=0;i<sceneNodes.size();i++){
     if(sceneNodes.size()>0){
     sceneNodes[i]->update(delta);
     }
     }
     */
}
/*
 void renderer::drawScene(glm::mat4 &view, glm::mat4 &projection, float *deltaTime, NODE* rootNode)
 {
 shader->bind();//Bind the shader for the rendering of this object
 
 shader->loadAttribute(_positionSlot,@"Position");
 shader->loadAttribute(_colorSlot,   @"SourceColor");
 shader->loadAttribute(_texCoordSlot,@"TexCoordIn");
 
 rootNode->draw();
 
 shader->unbind();//Release the shader for the next object
 }
 
 void renderer::drawRendererNodes(glm::mat4 &view, glm::mat4 &projection, float *deltaTime)
 {
 //Loop through all objects of base type OBJECT
 for(int i=0;i<sceneNodes.size();i++){
 if(sceneNodes.size()>0){
 
 shader->bind();//Bind the shader for the rendering of this object
 sceneNodes[i]->meshNode->bindBuffers();
 
 shader->loadAttribute(_positionSlot,@"Position");
 shader->loadAttribute(_colorSlot,   @"SourceColor");
 shader->loadAttribute(_texCoordSlot,@"TexCoordIn");
 
 sceneNodes[i]->meshNode->assignAttribs(_positionSlot,_colorSlot,_texCoordSlot);
 
 sceneNodes[i]->mv = view * sceneNodes[i]->model;
 shader->setUniform(@"modelViewMatrix", sceneNodes[i]->mv);//Calculate object model view
 shader->setUniform(@"MVP", projection * sceneNodes[i]->mv);//apply projection transforms to object
 
 shader->setUniform(@"red",   sceneNodes[i]->meshNode->getRed());
 shader->setUniform(@"green", sceneNodes[i]->meshNode->getGreen());
 shader->setUniform(@"blue",  sceneNodes[i]->meshNode->getBlue());
 shader->setUniform(@"alpha", sceneNodes[i]->meshNode->getAlpha());
 
 glActiveTexture(GL_TEXTURE0); // unneccc in practice
 glBindTexture(GL_TEXTURE_2D, sceneNodes[i]->meshNode->_texture);
 
 shader->setUniform(@"Texture", 0);//Apply the uniform for this instance
 
 sceneNodes[i]->draw();//Draw this object
 
 sceneNodes[i]->meshNode->unbindBuffers();
 shader->unbind();//Release the shader for the next object
 }
 }
 
 }
 
 void renderer::initRendererObjs()
 {
 for(int i=0;i<SceneObjects.size();i++){
 if(SceneObjects.size()>0){
 SceneObjects[i]->initBuffers();
 SceneObjects[i]->visible(true);
 }
 }
 }
 */


void renderer::drawRender(float *deltaTime)
{
    //shader->bind();
    
    //shader->loadAttribute(_positionSlot,@"Position");
    //shader->loadAttribute(_colorSlot,   @"SourceColor");
    //shader->loadAttribute(_texCoordSlot,@"TexCoordIn");
}

/*
 void renderer::parseObjects(std::vector<OBJECT*>Objs)
 {
 for(int i=0;i<Objs.size();i++){
 dynamicObjects.push_back(Objs[i]);
 }
 }
 
 void renderer::drawRender(glm::mat4 &view, glm::mat4 &projection, float *deltaTime)
 {
 //Loop through all objects of base type OBJECT
 for(int i=0;i<SceneObjects.size();i++){
 if(SceneObjects.size()>0){
 
 shader->bind();//Bind the shader for the rendering of this object
 SceneObjects[i]->bindBuffers();
 
 shader->loadAttribute(_positionSlot,@"Position");
 shader->loadAttribute(_colorSlot,   @"SourceColor");
 shader->loadAttribute(_texCoordSlot,@"TexCoordIn");
 
 SceneObjects[i]->assignAttribs(_positionSlot,_colorSlot,_texCoordSlot);
 
 SceneObjects[i]->mv = view * SceneObjects[i]->model;
 shader->setUniform(@"modelViewMatrix", SceneObjects[i]->mv);//Calculate object model view
 shader->setUniform(@"MVP", projection * SceneObjects[i]->mv);//apply projection transforms to object
 
 shader->setUniform(@"red",   SceneObjects[i]->getRed());
 shader->setUniform(@"green", SceneObjects[i]->getGreen());
 shader->setUniform(@"blue",  SceneObjects[i]->getBlue());
 shader->setUniform(@"alpha", SceneObjects[i]->getAlpha());
 
 glActiveTexture(GL_TEXTURE0); // unneccc in practice
 glBindTexture(GL_TEXTURE_2D, SceneObjects[i]->_texture);
 
 shader->setUniform(@"Texture", 0);//Apply the uniform for this instance
 
 SceneObjects[i]->draw();//Draw this object
 
 SceneObjects[i]->unbindBuffers();
 shader->unbind();//Release the shader for the next object
 }
 }
 }
 
 
 
 void renderer::updateRenderObjs()
 {
 for(int i=0;i<SceneObjects.size();i++){
 if(SceneObjects.size()>0)
 SceneObjects[i]->update();
 }
 }
 */
