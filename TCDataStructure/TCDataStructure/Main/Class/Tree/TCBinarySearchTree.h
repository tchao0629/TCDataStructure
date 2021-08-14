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

@end

NS_ASSUME_NONNULL_END
