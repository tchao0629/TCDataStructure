//
//  TCQueue.h
//  test
//
//  Created by tangchao on 2021/7/10.
//  Copyright © 2021年 tangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 队列 [线性表] [FIFO] [入队 出队]
 * 入队：从尾部入队
 * 出队：从头部出队
 */
@interface TCQueue<TCElement> : NSObject

/// 元素的数量
@property (nonatomic, assign, readonly) int size;

/// 是否为空
- (BOOL)isEmpty;
/// 清空
- (void)clear;

/// 入队
- (void)enQueue:(TCElement)element;
/// 出队
- (TCElement)deQueue;
/// 获取队头元素
- (TCElement)front;
@end
