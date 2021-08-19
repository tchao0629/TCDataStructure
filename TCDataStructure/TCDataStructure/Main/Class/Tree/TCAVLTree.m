//
//  TCAVLTree.m
//  TCDataStructure
//
//  Created by tangchao on 2021/8/18.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCAVLTree.h"

@implementation TCAVLTreeNode

- (NSInteger)balanceFactor {
    return _left.height - _right.height;
}

- (__kindof TCBinaryTreeNode *)tallerChild {
    NSInteger leftHeight = ((TCAVLTreeNode *)_left).height;
    NSInteger rightHeight = ((TCAVLTreeNode *)_right).height;
    
    if (leftHeight > rightHeight) {
        return _left;
    }
    
    if (leftHeight < rightHeight) {
        return _right;
    }
    
    return [self isLeftChild] ? _left : _right;
}

@end

@interface TCAVLTree ()

- (BOOL)isBalance:(TCAVLTreeNode *)node;
/** 恢复平衡
 * @param grand 高度最低的不平衡节点
 */
- (void)reBalance:(TCAVLTreeNode *)grand;

/// 左旋转
- (void)rotateLeft:(TCAVLTreeNode *)grand;
/// 右旋转
- (void)rotateRight:(TCAVLTreeNode *)grand;
/**
 * 旋转之后的操作
 * @param grand 失衡节点
 * @param parent 失衡节点的tallerChild
 * @param child grand、parent节点 需要交换的子树
 */
- (void)afterRotate:(TCAVLTreeNode *)grand parent:(TCAVLTreeNode *)parent child:(TCAVLTreeNode *)child;

@end

@implementation TCAVLTree

- (__kindof TCBinaryTreeNode *)createNodeWithElement:(id)element andParant:(__kindof TCBinaryTreeNode *)parent {
    return [[TCAVLTreeNode alloc] initWithElement:element andParent:parent];
}

- (void)afterAdd:(__kindof TCBinaryTreeNode *)node {
    while ((node = node.parent) != nil) {
        if ([self isBalance:node]) {
            /// 更新高度
            [node updateHeight];
        } else {
            /// 恢复平衡
            [self reBalance:node];
            /// 整棵🌲已平衡
            break;
        }
    }
}

- (void)afterRemove:(__kindof TCBinaryTreeNode *)node {
    while ((node = node.parent) != nil) {
        if ([self isBalance:node]) {
            /// 更新高度
            [node updateHeight];
        } else {
            /// 恢复平衡
            [self reBalance:node];
        }
    }
}

- (void)rotateLeft:(TCAVLTreeNode *)grand {
    /// 交换子树
    TCAVLTreeNode *parent = grand.right;
    TCAVLTreeNode *child = parent.left;
    grand.right = child;
    parent.left = grand;
    
    /// 旋转之后，维护grand parent child 节点的父指针指向，grand parent 节点更新高度
    [self afterRotate:grand parent:parent child:child];
}

- (void)rotateRight:(TCAVLTreeNode *)grand {
    /// 交换子树
    TCAVLTreeNode *parent = grand.left;
    TCAVLTreeNode *child = parent.right;
    grand.left = child;
    parent.right = grand;
    
    /// 旋转之后，维护grand parent child 节点的父指针指向，grand parent 节点更新高度
    [self afterRotate:grand parent:parent child:child];
}

- (void)afterRotate:(TCAVLTreeNode *)grand parent:(TCAVLTreeNode *)parent child:(TCAVLTreeNode *)child {
    /// 让parent节点成为子树的根节点
    if ([grand isLeftChild]) {
        grand.parent.left = parent;
    } else if ([grand isRightChild]) {
        grand.parent.right = parent;
    } else {
        _root = parent;
    }
    
    /// 维护父指针指向 [grand parent child]
    parent.parent = grand.parent;
    grand.parent = parent;
    if (child) {
        child.parent = grand;
    }
    
    /// 更新节点高度 [grand parent] [先更新高度小的grand 再更新高度大的parent]
    [grand updateHeight];
    [parent updateHeight];
}

#pragma mark - Private Methods
- (BOOL)isBalance:(TCAVLTreeNode *)node {
    return labs(node.balanceFactor) <= 1;
}

- (void)reBalance:(TCAVLTreeNode *)grand {
    TCAVLTreeNode *parent = grand.tallerChild;
    TCAVLTreeNode *node = parent.tallerChild;
    if ([parent isLeftChild]) { /// L
        if ([node isLeftChild]) { /// LL
            /// 祖父节点 右旋转 （单旋）
            [self rotateRight:grand];
        } else { /// LR
            /// 先父节点左旋转 再祖父节点右旋转（双旋）
            [self rotateLeft:parent];
            [self rotateRight:grand];
        }
    } else { /// R
        if ([node isLeftChild]) { /// RL
            /// 先父节点右旋转 再祖父节点左旋转（双旋）
            [self rotateRight:parent];
            [self rotateLeft:grand];
        } else { /// RR
            /// 祖父节点 左旋转（单旋）
            [self rotateLeft:grand];
        }
    }
}

@end
