//
//  TCBinaryTree.h
//  Test
//
//  Created by tangchao on 2021/8/14.
//  Copyright © 2021 Midas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 二叉树的节点 */
@interface TCBinaryTreeNode<TCElement> : NSObject {
    @protected
    TCElement _element;
    __kindof TCBinaryTreeNode *_left;
    __kindof TCBinaryTreeNode *_right;
    __kindof TCBinaryTreeNode *_parent;
}

@property (nonatomic, strong) TCElement element;
@property (nonatomic, strong, nullable) __kindof TCBinaryTreeNode *left;
@property (nonatomic, strong, nullable) __kindof TCBinaryTreeNode *right;
@property (nonatomic, strong, nullable) __kindof TCBinaryTreeNode *parent;

- (instancetype)initWithElement:(TCElement)element andParent:(nullable __kindof TCBinaryTreeNode<TCElement> *)parent;

/// 是否为叶子节点
- (BOOL)isLeaf;
/// 是否有两个子节点
- (BOOL)hasTwoChild;

@end

@interface TCBinaryTree<TCElement> : NSObject {
    @protected
    NSInteger _size;
    TCBinaryTreeNode<TCElement> *_root;
}

@property (nonatomic, assign, readonly) NSInteger size;
/// 树的高度
@property (nonatomic, assign, readonly) NSInteger height;

- (BOOL)isEmpty;
- (void)clear;

- (BOOL)contains:(TCElement)element;

- (void)add:(TCElement)element;
- (TCElement)remove:(TCElement)element;

/// 是否为完全二叉树
- (BOOL)isComplete;

/// 前驱节点
- (__kindof TCBinaryTreeNode *)predecessor:(__kindof TCBinaryTreeNode *)node;
/// 后继节点
- (__kindof TCBinaryTreeNode *)successor:(__kindof TCBinaryTreeNode *)node;

/// 前序遍历
- (void)preorder:(void(^)(TCElement e, BOOL *stop))visitor;
/// 中序遍历
- (void)inorder:(void(^)(TCElement e, BOOL *stop))visitor;
/// 后序遍历
- (void)postorder:(void(^)(TCElement e, BOOL *stop))visitor;
/// 层序遍历
- (void)levelOrder:(void(^)(TCElement e, BOOL *stop))visitor;

/// 检查元素不为nil
- (BOOL)checkElementNotNull:(TCElement)element;

@end

NS_ASSUME_NONNULL_END
