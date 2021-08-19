//
//  TCAVLTree.h
//  TCDataStructure
//
//  Created by tangchao on 2021/8/18.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCBinarySearchTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface TCAVLTreeNode : TCBinaryTreeNode 

/// 平衡因子
@property (nonatomic, assign, readonly) NSInteger balanceFactor;
/// 高度大的子节点
- (__kindof TCBinaryTreeNode *)tallerChild;

@end

/** 艾薇儿树 自平衡搜索树 */
@interface TCAVLTree : TCBinarySearchTree

@end

NS_ASSUME_NONNULL_END
