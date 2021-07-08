//
//  TCCircleLinkedList.h
//  TCDataStructure
//
//  Created by tangchao on 2021/7/8.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCAbstractList.h"

NS_ASSUME_NONNULL_BEGIN
/** 双向循环链表 [不能添加nil元素] */
@interface TCCircleLinkedList<TCElement> : TCAbstractList<TCElement>

/// 重置
- (void)reset;
/// 下一个元素
- (TCElement)next;
/// 删除当前元素
- (TCElement)remove;

@end

NS_ASSUME_NONNULL_END
