//
//  nodePath.cpp
//  oglApp
//
//  Created by SimonJordan on 23/03/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#include "nodePath.h"

//!!!!Needs more testing and work to ensure all desired functionality is gained!!!!

nodePath::nodePath():nodeIDs(0)
{
    
}
nodePath::~nodePath()
{
    
}


void nodePath::set_NodeID(NODEUI *node, int nodeID)
{
    node->_id = nodeID;
}

void nodePath::set_NodeParentID(NODEUI *node)
{
    NODEUI* temp = get_NodeParent(node);
    node->_parentID = temp->_id;
}

NODEUI* nodePath::get_NodeParent(NODEUI *node)
{
    return node->parentNode;
}

int nodePath::get_NodeID(NODEUI *node)
{
    return node->_id;
}



//Copy the parents node path, including the parent into a vector
//that can be assigned to a new parent
std::vector<NODEUI*> nodePath::get_NodePathFromParent(NODEUI* parentNode)
{
    std::vector<NODEUI*> pathBuffer;
    
    if(parentNode){
        pathBuffer.push_back(parentNode);
    }
    if(!parentNode->childNodes.empty())
    {
        for(int i=0; i<parentNode->childNodes.size();++i)
        {
            if(NULL != parentNode->childNodes[i])
                pathBuffer.push_back(parentNode->childNodes[i]);
        }
    }
    return pathBuffer;
}
//Copy the node path exluding the parent that can be assigned to a
//new parent
std::vector<NODEUI*> nodePath::get_NodePathfromChildren(NODEUI* parentNode)
{
    std::vector<NODEUI*> pathBuffer;
    NODEUI* tempNode;
    //pathBuffer.push_back(NODE* cpyNode = new NODE());
    if(!parentNode->childNodes.empty())
    {
        for(int i=0; i<parentNode->childNodes.size();++i)
        {
            if(NULL != parentNode->childNodes[i])
            {
                pathBuffer.push_back(tempNode = new NODEUI(parentNode->childNodes[i]->meshNode2D));
            }
        }
    }
    //safeDelete(tempNode);
    return pathBuffer;
}
//Copy the nodes under one parent to a new parent, whilst the initial
//parent retains the nodes.
//If the new parent already has nodes, attatch existing path
//otherwise create a new path
bool nodePath::copy_FromChildren(NODEUI *newParent, NODEUI *oldParent)
{
    if(newParent&&oldParent)
    {
        if (!oldParent->childNodes.empty()) {
            for(int i = 0; i<oldParent->childNodes.size();++i){
                if(NULL != oldParent->childNodes[i])
                {
                    std::vector<NODEUI*> nodeBuffer = get_NodePathfromChildren(oldParent);
                    for(int i = 0; i< oldParent->childNodes.size();++i)
                    {
                        newParent->addChildNode(nodeBuffer[i]);
                    }
                }
            }
            
        }
        return true;
    } else {
        return false;
    }
}
//Copy to children to new parent, but remove children from initial parent
//but survive with new parent
bool nodePath::copy_FromChildrenKillChildren(NODEUI *newParent, NODEUI *oldParent)
{
    if(newParent&&oldParent)
    {
        if (!oldParent->childNodes.empty()) {
            if(!newParent->childNodes.empty()){
                for(int i = 0; i<oldParent->childNodes.size();++i){
                    if(NULL != oldParent->childNodes[i])
                        newParent->childNodes.push_back(oldParent->childNodes[i]);
                }
                
            }else {
                newParent->childNodes = get_NodePathfromChildren(oldParent);
            }
            delete_ParentNodePath(oldParent);
        }
        
        return true;
        
    } else {
        return false;
    }
}

bool nodePath::copy_FromParent(NODEUI *newParent, NODEUI *oldParent)
{
    if(newParent&&oldParent)
    {
        if (!oldParent->childNodes.empty()) {
            if(!newParent->childNodes.empty()){
                for(int i = 0; i<oldParent->childNodes.size();++i){
                    if(NULL != oldParent->childNodes[i])
                        newParent->childNodes.push_back(oldParent->childNodes[i]);
                }
                
            }else {
                newParent->childNodes = get_NodePathFromParent(oldParent);
            }
        }
        return true;
    } else {
        return false;
    }
}
//Copy children to new parent but remove children from initial parent
//and the parent.
//NOTE:
//This should be safe to use as children dependant on parent are removed
//In future, might need to check for external dependancies
bool nodePath::copy_FromParentKillParent(NODEUI *newParent, NODEUI *oldParent)
{
    if(newParent&&oldParent)
    {
        if (!oldParent->childNodes.empty()) {
            if(!newParent->childNodes.empty()){
                for(int i = 0; i<oldParent->childNodes.size();++i){
                    if(NULL != oldParent->childNodes[i])
                        newParent->childNodes.push_back(oldParent->childNodes[i]);
                }
                
            }else {
                newParent->childNodes = get_NodePathFromParent(oldParent);
            }
            delete_ParentAndNodePath(oldParent);
        }
        
        return true;
    } else {
        return false;
    }
}



//Similiar to getNodePathFromChildren, but we distinguish as a seperate tool
//to compliment iterateChildPathBack for navigating path nodes under a parent
std::vector<NODEUI*> nodePath::iterate_ChildPathForward(NODEUI* parentNode)
{
    std::vector<NODEUI*> pathBuffer;
    
    if(!parentNode->childNodes.empty())
    {
        for(std::vector<NODEUI*>::iterator i =parentNode->getChildIteratorStart(); i != parentNode->getChildIteratorEnd(); ++i)
        {
            pathBuffer.push_back(*i);
        }
    }
    
    return pathBuffer;
}

std::vector<NODEUI*> nodePath::iterate_ChildPathBack(NODEUI* parentNode)
{
    std::vector<NODEUI*> pathBuffer;
    if(!parentNode->childNodes.empty())
    {
        for(std::vector<NODEUI*>::iterator i =parentNode->getChildIteratorEnd(); i != parentNode->getChildIteratorStart(); --i)
        {
            pathBuffer.push_back(*i);
        }
    }
    
    return pathBuffer;
}

//Remove the children under a parent
bool nodePath::delete_ParentNodePath(NODEUI* parentNode)
{
    if(NULL != parentNode){
        parentNode->childNodes.clear();
        return true;
    } else {
        return false;
    }
}

bool nodePath::delete_ParentAndNodePath(NODEUI* parentNode)
{
    if(NULL != parentNode){
        parentNode->childNodes.clear();
        safeDelete(parentNode);
        return true;
    } else {
        return false;
    }
}






