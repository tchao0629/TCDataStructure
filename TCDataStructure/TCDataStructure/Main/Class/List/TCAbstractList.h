//
//  TCAbstractList.h
//  TCDataStructure
//
//  Created by tangchao on 2021/7/2.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern int const  ELEMENT_NOT_FOUND;

/** 线性表(抽象类) */
@interface TCAbstractList<TCElement> : NSObject {
    @protected
    /** 元素的数量 */
    int _size;
}

/// 元素的数量
@property (nonatomic, assign, readonly) int size;
/**
 * 清除所有元素
 */
- (void)clear;

/**
 * 是否为空
 */
- (BOOL)isEmpty;

/**
 * 是否包含某个元素
 */
- (BOOL)contains:(TCElement)element;

/**
 * 添加元素到尾部
 */
- (void)addElement:(TCElement)element;

/**
 * 在index位置插入一个元素
 * @param element 元素
 * @param index 位置
 */
- (void)addElement:(TCElement)element forIndex:(int)index;

/**
 * 获取index位置的元素
 * @param index 位置
 */
- (TCElement)getElementForIndex:(int)index;

/**
 * 设置index位置的元素
 * @param element 元素
 * @param index 位置
 * @return 原来的元素
 */
- (TCElement)setElement:(TCElement)element forIndex:(int)index;

/**
 * 删除元素
 * @param element 元素
 * @return 原来的元素
 */
- (TCElement)removeElement:(TCElement)element;

/**
 * 删除index位置的元素
 * @param index 位置
 * @return 被删除的元素
 */
- (TCElement)removeElementForIndex:(int)index;

/**
 * 查看元素的索引
 * @param element 元素
 * @return 元素的索引
 */
- (int)indexOf:(TCElement)element;

#pragma mark - Protected Methods
/// 检测index是否合法
- (BOOL)checkIndex:(int)index;
/// 检测添加时index是否合法
- (BOOL)checkIndexForAdd:(int)index;
/// tip: index越界
- (void)outOfBounds:(int)index;

@end

NS_ASSUME_NONNULL_END
