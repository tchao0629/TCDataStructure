//
//  TCDeque.h
//  TCDataStructure
//
//  Created by tangchao on 2021/7/12.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 双端队列 [线性表] [入队 出队]
* 入队：从队尾或队头入队
* 出队：从队头或队尾出队
*/
@interface TCDeque<TCElement> : NSObject

/// 元素的数量
@property (nonatomic, assign, readonly) int size;

/// 是否为空
- (BOOL)isEmpty;
/// 清空
- (void)clear;

/// 入队(队尾)
- (void)enQueueRear:(TCElement)element;
/// 出队(队头)
- (TCElement)deQueueFront;

/// 入队(队头)
- (void)enQueueFront:(TCElement)element;
/// 出队(队尾)
- (TCElement)deQueueRear;

/// 获取队头元素
- (TCElement)front;
/// 获取队尾元素
- (TCElement)rear;

@end

NS_ASSUME_NONNULL_END
