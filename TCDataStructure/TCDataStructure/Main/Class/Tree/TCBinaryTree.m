//
//  TCBinaryTree.m
//  Test
//
//  Created by tangchao on 2021/8/14.
//  Copyright © 2021 Midas. All rights reserved.
//

#import "TCBinaryTree.h"
#import "TCQueue.h"

@implementation TCBinaryTreeNode

- (instancetype)initWithElement:(id)element andParent:(__kindof TCBinaryTreeNode *)parent {
    if (self = [super init]) {
        _element = element;
        _parent = parent;
        
        /// 初始化高度为1
        _height = 1;
    }
    return self;
}

- (NSInteger)height {
    return _height;
}

- (BOOL)isLeaf {
    return !_left && !_right;
}

- (BOOL)hasTwoChild {
    return _left && _right;
}

- (BOOL)isLeftChild {
    return _parent && _parent.left == self;
}

- (BOOL)isRightChild {
    return _parent && _parent.right == self;
}

- (void)updateHeight {
    _height = MAX(_left.height, _right.height) + 1;
}

@end

@interface TCBinaryTree<TCElement> ()

- (void)preorderWithNode:(TCBinaryTreeNode *)node stop:(BOOL *)stop visitor:(void(^)(TCElement e, BOOL *stop))visitor;
- (void)inorderWithNode:(TCBinaryTreeNode *)node stop:(BOOL *)stop visitor:(void(^)(TCElement e, BOOL *stop))visitor;
- (void)postorderWithNode:(TCBinaryTreeNode *)node stop:(BOOL *)stop visitor:(void(^)(TCElement e, BOOL *stop))visitor;

- (NSInteger)heightForNode:(TCBinaryTreeNode *)node;

@end

@implementation TCBinaryTree

- (instancetype)init {
    if (self = [super init]) {
        _size = 0;
        _root = nil;
    }
    return self;
}

- (NSInteger)size {
    return _size;
}
- (NSInteger)height {
    return [self heightForNode:_root];
}
- (NSInteger)heightForNode:(TCBinaryTreeNode *)node {
    if (!node) {
        return 0;
    }
    
    return MAX([self heightForNode:node.left], [self heightForNode:node.right]) + 1;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (void)clear {
    _size = 0;
    _root = nil;
}

- (BOOL)isComplete {
    if (!_root) {
        return NO;
    }
    
    TCQueue *queue = [[TCQueue alloc] init];
    [queue enQueue:_root];
    
    BOOL isLeaf = NO;
    while (![queue isEmpty]) {
        TCBinaryTreeNode *node = [queue deQueue];
        
        if (isLeaf && ![node isLeaf]) {
            return NO;
        }
        
        if (node.left) {
            [queue enQueue:node.left];
        } else if (node.right) { /// node.left == nil && node.right != nil
            return NO;
        }
        
        if (node.right) {
            [queue enQueue:node.right];
        } else { /// node.right == nil
            isLeaf = YES;
        }
    }
    return YES;
}

- (__kindof TCBinaryTreeNode *)predecessor:(__kindof TCBinaryTreeNode *)node {
    if (!node) {
        return nil;
    }
    
    /// 在左子树中查找
    TCBinaryTreeNode *pre = node.left;
    if (pre) {
        while (pre.right) {
            pre = pre.right;
        }
        return pre;
    }
    
    /// 在父节点或祖父节点查找
    while (node.parent && node == node.parent.left) {
        node = node.parent;
    }
    
    /// find: node == node.parent.right
    /// not find: node.parent == nil
    return node.parent;
}

- (__kindof TCBinaryTreeNode *)successor:(__kindof TCBinaryTreeNode *)node {
    if (!node) {
        return nil;
    }
    
    /// 在右子树中查找
    TCBinaryTreeNode *pre = node.right;
    if (pre) {
        while (pre.left) {
            pre = pre.left;
        }
        return pre;
    }
    
    /// 在父节点或祖父节点查找
    while (node.parent && node == node.parent.right) {
        node = node.parent;
    }
    
    /// find: node == node.parent.left
    /// not find: node.parent == nil
    return node.parent;
}

- (void)preorder:(void (^)(id _Nonnull, BOOL * _Nonnull))visitor {
    if (!visitor) {
        return;
    }
    
    BOOL stop = NO;
    [self preorderWithNode:_root stop:&stop visitor:visitor];
}

- (void)preorderWithNode:(TCBinaryTreeNode *)node stop:(BOOL *)stop visitor:(void (^)(id, BOOL *))visitor {
    if (!node) {
        return;
    }
    
    if (*stop) {
        return;
    }
    
    visitor(node.element, stop);
    [self preorderWithNode:node.left stop:stop visitor:visitor];
    [self preorderWithNode:node.right stop:stop visitor:visitor];
}

- (void)inorder:(void (^)(id _Nonnull, BOOL * _Nonnull))visitor {
    if (!visitor) {
        return;
    }
    
    BOOL stop = NO;
    [self inorderWithNode:_root stop:&stop visitor:visitor];
}
- (void)inorderWithNode:(TCBinaryTreeNode *)node stop:(BOOL *)stop visitor:(void (^)(id, BOOL *))visitor {
    if (!node) {
        return;
    }
    
    [self inorderWithNode:node.left stop:stop visitor:visitor];
    if (*stop) {
        return;
    }
    visitor(node.element, stop);
    [self inorderWithNode:node.right stop:stop visitor:visitor];
}
- (void)postorder:(void (^)(id _Nonnull, BOOL * _Nonnull))visitor {
    if (!visitor) {
        return;
    }
    
    BOOL stop = NO;
    [self postorderWithNode:_root stop:&stop visitor:visitor];
}
- (void)postorderWithNode:(TCBinaryTreeNode *)node stop:(BOOL *)stop visitor:(void (^)(id, BOOL *))visitor {
    if (!node) {
        return;
    }
    
    [self postorderWithNode:node.left stop:stop visitor:visitor];
    [self postorderWithNode:node.right stop:stop visitor:visitor];
    
    if (*stop) {
        return;
    }
    visitor(node.element, stop);
}
- (void)levelOrder:(void (^)(id _Nonnull, BOOL * _Nonnull))visitor {
    if (!visitor) {
        return;
    }
    
    if (!_root) {
        return;
    }
    
    TCQueue *queue = [[TCQueue alloc] init];
    [queue enQueue:_root];
    
    BOOL stop = NO;
    while (![queue isEmpty]) {
        TCBinaryTreeNode *node = [queue deQueue];
        if (stop) {
            return ;
        }
        visitor(node.element, &stop);
        
        if (node.left) {
            [queue enQueue:node.left];
        }
        
        if (node.right) {
            [queue enQueue:node.right];
        }
    }
    
}

- (BOOL)checkElementNotNull:(id)element {
    if (element) {
        return YES;
    }
    NSAssert(NO, @"element is nil.");
    return NO;
}

@end
