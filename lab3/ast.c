#include "ast.h"
#include <stdlib.h>
#include <stdio.h>
#include "common.h"

struct node *root = NULL;

void preorder(node * currnode, void(*f)(struct node *)){
    if(currnode == NULL)return;
    
    // call myself before calling child
    f(currnode);
    
    // call the childs first
    int i;
    for(i = 0; i < currnode->nkids; i ++)
        preorder(currnode->kids[i], f);
   
}
void postorder(node * currnode, void(*f)(struct node *)){
    if(currnode == NULL)return;
    
    // call the childs first
    int i;
    for(i = 0; i < currnode->nkids; i ++)
        postorder(currnode->kids[i], f);
    
    // call myself after calling childs
    f(currnode);
}

struct node *ast_allocate(node_kind mykind, int kidcount, ...){
    // should have at least one kid
    if(kidcount < 0){
        fprintf(errorFile, "ast_allocate: kind count is smaller than zero (%d)\n", kidcount);
        return NULL;
    }
    
    int i;
    va_list ap;
    struct node * ptr = (struct node*)malloc(sizeof(struct node) + sizeof(struct node*)*(kidcount-1));
    if (ptr == NULL){
        fprintf(errorFile, "ast_allocate: Could not dynmaic allocate memory for new node\n");
        return NULL;
    }
    
    // successfully created
    ptr->mykind = mykind;
    ptr->nkids = kidcount;
    va_start(ap, kidcount);
    for(i = 0; i<kidcount; i ++)
        ptr->kids[i] = va_arg(ap, struct node*);
    va_end(ap);
    
    // result is found. return
    return ptr;
}

void myFree(struct node *root){
    free(root);
}
void free_tree(struct node * root){
    postorder(root, myFree);
}