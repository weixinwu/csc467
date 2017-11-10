#ifndef _AST_H
#define _AST_H

#include <stdarg.h>

// Dummy node just so everything compiles, create your own node/nodes
//
// The code provided below is an example ONLY. You can use/modify it,
// but do not assume that it is correct or complete.
//
// There are many ways of making AST nodes. The approach below is an example
// of a descriminated union. If you choose to use C++, then I suggest looking
// into inheritance.

// forward declare
struct node;
extern node *root;

typedef enum {
    // non-ternminals node type
    NKIND_INSTRUCTIONS,
    NKIND_INSTRUCTION,
    //NKINDS_VALUE,
    //NKINDS_TYPE,
    NKIND_INDEX,
    NKIND_DECLARATION,
    NKIND_ASSIGNMENT,
    //NKIND_EXPRESSION,
    NKIND_IF,
    NKIND_EIF,
    NKIND_STATEMENT,
    NKIND_LOOP,
    //NKIND_COMPARE,
                        
    // ternminal node values
    NKIND_INT,
    NKIND_FLOAT,
    NKIND_IDENT,

    // terminal node type
    NKIND_BVEC2,
    NKIND_BVEC3,
    NKIND_BVEC4,

    NKIND_IVEC2,
    NKIND_IVEC3,
    NKIND_IVEC4,

    NKIND_VEC2,
    NKIND_VEC3,
    NKIND_VEC4,
            
    // expression
    NKIND_EXP_PLUS,
    NKIND_EXP_MINUS,
    NKIND_EXP_MULTI,
    NKIND_EXP_DIVID,
    NKIND_EXP_EXPO,
    NKIND_EXP_COMP,
    NKIND_EXP_AND,
    NKIND_EXP_OR,
    NKIND_EXP_NOT,
            
    // compare
    NKIND_COMP_EQUAL,
    NKIND_COMP_NOT_EQUAL,
    NKIND_COMP_GREATER,
    NKIND_COMP_LESS,
    NKIND_COMP_GREATER_EQUAL,
    NKIND_COMP_LESS_EQUAL
} node_kind;

struct node {
    node_kind mykind;
    int nkids;
    struct node * kids[1];
};

/* called in parser.y, each token identifed will dynamically create a node
 * also insert previous created node into kids list
 * on each token identifed, it already know how many kids is supposed to be created
 */
struct node *ast_allocate(node_kind mykind, int kidcount, ...);

/* should be called when the tree is not useful anymore
 * It should be called with a postorder manner
 */
void free_tree(struct node * root);

#endif
