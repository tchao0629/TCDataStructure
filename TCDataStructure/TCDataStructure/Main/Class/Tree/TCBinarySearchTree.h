//
//  TCBinarySearchTree_05.h
//  Test
//
//  Created by tangchao on 2021/8/14.
//  Copyright © 2021 Midas. All rights reserved.
//

#import "TCBinaryTree.h"

NS_ASSUME_NONNULL_BEGIN
/** 二叉搜索树 */
@interface TCBinarySearchTree<TCElement> : TCBinaryTree<TCElement>

- (instancetype)init NS_UNAVAILABLE;
/// comparator 比较器
- (instancetype)initWithComparator:(int(^)(TCElement e1, TCElement e2))comparator;

- (BOOL)contains:(TCElement)element;

- (void)add:(TCElement)element;
- (TCElement)remove:(TCElement)element;

- (__kindof TCBinaryTreeNode *)createNodeWithElement:(TCElement)element andParant:(nullable __kindof TCBinaryTreeNode *)parent;

/**
 * 添加node之后的调整
 * @param node 新添加的节点
 */
- (void)afterAdd:(__kindof TCBinaryTreeNode *)node;
/**
 * 删除node之后的调整
 * @param node 被删除的节点
 */
- (void)afterRemove:(__kindof TCBinaryTreeNode *)node;

@end

NS_ASSUME_NONNULL_END
