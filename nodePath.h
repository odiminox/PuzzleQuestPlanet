//
//  nodePath.h
//  oglApp
//
//  Created by SimonJordan on 23/03/2013.
//  Copyright (c) 2013 Simon Jordan. All rights reserved.
//

#ifndef __oglApp__nodePath__
#define __oglApp__nodePath__

#include "NODEUI.h"
#include <vector>
#include "memoryManager.h"
#include <vector>


class nodePath {
    
    
public:
    nodePath();
    ~nodePath();
    
    void add_ToNodePath(NODEUI* node, NODEUI* parent);
    void add_ParentToGraph(NODEUI* parent);
       
    
    std::vector<NODEUI*> iterate_ChildPathForward(NODEUI* parentNode);
    std::vector<NODEUI*> iterate_ChildPathBack(NODEUI* parentNode);
    
    std::vector<NODEUI*> get_NodePathFromParent(NODEUI* parentNode);
    std::vector<NODEUI*> get_NodePathfromChildren(NODEUI* parentNode);
    std::vector<NODEUI*> get_PathNodes();
    int                get_NodeID(NODEUI* node);
    NODEUI*              get_NodeParent(NODEUI* node);
    
    bool copy_FromChildren(NODEUI* newParent, NODEUI* oldParent);
    bool copy_FromChildrenKillChildren(NODEUI* newParent, NODEUI* oldParent);
    bool copy_FromParent(NODEUI* newParent, NODEUI* oldParent);
    bool copy_FromParentKillParent(NODEUI* newParent, NODEUI* oldParent);

    bool delete_ParentNodePath(NODEUI* parentNode);
    bool delete_ParentAndNodePath(NODEUI* parentNode);
    
    bool delete_Node(int nodeNum);

    void set_NodeID(NODEUI* node, int nodeID);
    void set_NodeParentID(NODEUI* node);

    
private:
    int nodeIDs;
    std::vector<NODEUI*> parents;
    
};

#endif /* defined(__oglApp__nodePath__) */
