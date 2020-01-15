//
//  NODE.cpp
//  oglApp
//
//  Created by SimonJordan on 22/03/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "NODEUI.h"

NODEUI::NODEUI(MESH2D* nodeMesh):parentNode(NULL),meshNode2D(NULL)
{
	model = glm::mat4(1.0f);
	worldTranslate = glm::mat4(1.0f);

	meshNode2D = nodeMesh;
    isNodeDirty = true;
    renderMe = false;
}


NODEUI::~NODEUI()
{
	for(int i =0; i< childNodes.size(); i++)
	{
		safeDelete(childNodes[i]);
	}
}


void NODEUI::setRenderOrderID(float ID)
{
    _renderOrderID = ID;
}
float NODEUI::getRenderOrderID()
{
    return _renderOrderID;
}

void NODEUI::setBlockRenderORderID(float ID)
{
    _blockrenderOrderID = ID;
}
float NODEUI::getBlockRenderOrderID()
{
    return _blockrenderOrderID;
}

void NODEUI::update(float delta)
{
	//first update normal matrix transformations
	scaleMatrix     = glm::scale(glm::mat4(1.0f), glm::vec3(scale.x,scale.y,scale.z));
	translateMatrix = glm::translate(glm::mat4(1.0f), glm::vec3(positon.x,positon.y,positon.z));

	model = worldTranslate * worldRotate * worldScale;
    /*
    boxModel = worldTranslate * worldRotate * worldScale;
    
    size = glm::vec3(meshNode2D->max_x-meshNode2D->min_x, meshNode2D->max_y-meshNode2D->min_y, meshNode2D->max_z-meshNode2D->min_z);
    center = glm::vec3((meshNode2D->min_x+meshNode2D->max_x)/2, (meshNode2D->min_y+meshNode2D->max_y)/2, (meshNode2D->min_z+meshNode2D->max_z)/2);
    transform = glm::scale(glm::mat4(1), size) * glm::translate(glm::mat4(1), center);
    */
    /* Apply object's transformation matrix */
    


    

	//If we have a parent node, we update translate via the parent
	if(parentNode){
		worldTranslate = parentNode->worldTranslate * translateMatrix;
		worldRotate    = parentNode->worldRotate    * rotateMatrix;
		worldScale     = parentNode->worldScale     * scaleMatrix;
        
	} else {
		//otherwise independently
		worldTranslate = translateMatrix;
		worldRotate    = rotateMatrix;
		worldScale     = scaleMatrix;
	}
    

	//parent node is responsible for updating children nodes. If no children, skips
	if(!childNodes.empty()){
		for(int i =0; i< childNodes.size(); i++){
			childNodes[i]->update(delta);
		}
	}
}

void NODEUI::init(renderer* Renderer)
{
	//Do we have a valid mesh?
	if(NULL != meshNode2D && isNodeDirty  == true){
        NSLog(@"INIT NODE");
        isNodeDirty = false;
		meshNode2D->initBuffers(Renderer);
		meshNode2D->visible(true);
	}
	//Does this node have children?
	if(!childNodes.empty()){
		for(int i =0; i<childNodes.size();i++){
			childNodes[i]->init(Renderer);
		}
	}
}

void NODEUI::draw(renderer* Renderer)
{
	//Node is responsible for handling its mesh draw. Node is handled by the renderer
	if(NULL != meshNode2D && renderMe == true)
	{
		mv = Renderer->view * model;
		Renderer->shader->setUniform(@"modelViewMatrix", mv);
		Renderer->shader->setUniform(@"MVP", Renderer->projection * mv);
        
        //glm::mat4 m = boxModel * transform;
        //boxModelView = boxModel * transform;
        //Renderer->shader->setUniform(@"modelViewMatrix", boxModelView);
        //Renderer->shader->setUniform(@"MVP", Renderer->projection * boxModelView);

         
        meshNode2D->draw(Renderer);
	}

	if(!childNodes.empty()){
		for(int i =0; i<childNodes.size();i++){
			//This might not be needed as child node gets draw called
			childNodes[i]->mv = Renderer->view * childNodes[i]->model;
			Renderer->shader->setUniform(@"modelViewMatrix", childNodes[i]->mv);
			Renderer->shader->setUniform(@"MVP", Renderer->projection * childNodes[i]->mv);
            
            /*
            childNodes[i]->boxModelView = Renderer->view * childNodes[i]->boxModel;
            Renderer->shader->setUniform(@"modelViewMatrix", boxModelView);
            Renderer->shader->setUniform(@"MVP", Renderer->projection * boxModelView);
             */
			childNodes[i]->draw(Renderer);
        }
	}
}

void NODEUI::addChildNode(NODEUI* childNode)
{
	childNode->parentNode = this;
	childNodes.push_back(childNode);
}

void NODEUI::removeChild(NODEUI *childNode)
{
	if(NULL != childNode){
		if(!childNodes.empty()){
			for(int i = 0; i < childNodes.size();i++){
				if(childNodes[i] == childNode){
					childNodes.erase(childNodes.begin() + i);
					break;
				}
			}
		}
	}
}

void NODEUI::addMesh(MESH2D* nodeMesh)
{
	meshNode2D = nodeMesh;
}


void NODEUI::rotateX(GLfloat amount){
	rotateMatrix  = glm::rotate(glm::mat4(1.0f), amount, glm::vec3(1.0f,0.0f,0.0f));
	rotX = amount;
}
void NODEUI::rotateY(GLfloat amount){
	rotateMatrix  = glm::rotate(glm::mat4(1.0f), amount, glm::vec3(0.0f,1.0f,0.0f));
	rotY = amount;
}
void NODEUI::rotateZ(GLfloat amount){
	rotateMatrix  = glm::rotate(glm::mat4(1.0f), amount, glm::vec3(0.0f,0.0f,1.0f));
	rotZ += amount;
}

void NODEUI::offsetToXPoint(GLfloat x, GLfloat speed)
{
    while(this->positon.x != x){
        offsetX(speed);
    }
}
void NODEUI::offsetToYPoint(GLfloat y, GLfloat speed)
{
    
}
void NODEUI::offsetToZPoint(GLfloat z, GLfloat speed)
{
    
}

void NODEUI::scaleX(GLfloat amount){this->scale.x = amount;}
void NODEUI::scaleY(GLfloat amount){this->scale.y = amount;}
void NODEUI::scaleZ(GLfloat amount){this->scale.z = amount;}

void NODEUI::offsetScaleX(GLfloat amount){this->scale.x += amount;}
void NODEUI::offsetScaleY(GLfloat amount){this->scale.y += amount;}
void NODEUI::offsetScaleZ(GLfloat amount){this->scale.z += amount;}

void NODEUI::translateX(GLfloat amount){this->positon.x = amount;}
void NODEUI::translateY(GLfloat amount){this->positon.y = amount;}
void NODEUI::translateZ(GLfloat amount){this->positon.z = amount;}

void NODEUI::offsetX(GLfloat amount){this->positon.x += amount;}
void NODEUI::offsetY(GLfloat amount){this->positon.y += amount;}
void NODEUI::offsetZ(GLfloat amount){this->positon.z += amount;}

float NODEUI::getPosX(){return this->positon.x;}
float NODEUI::getPosY(){return this->positon.y;}
float NODEUI::getPosZ(){return this->positon.z;}

float NODEUI::getScaleX(){return this->scale.x;}
float NODEUI::getScaleY(){return this->scale.y;}
float NODEUI::getScaleZ(){return this->scale.z;}

float NODEUI::getRotX(){return this->rotX;}
float NODEUI::getRotY(){return this->rotY;}
float NODEUI::getRotZ(){return this->rotZ;}
