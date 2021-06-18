//
//  TCStack.h
//  TCDataStructure
//
//  Created by tangchao on 2021/6/18.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 栈 FILO (first int last out)*/
@interface TCStack<TCElement> : NSObject {
    /** 元素的数量 */
    NSUInteger _size;
}

/** 是否为空 */
- (BOOL)isEmpty;

/** 入栈 */
- (void)push:(TCElement)element;
/** 出栈 */
- (TCElement)pop;

/** 获取栈顶元素 */
- (TCElement)top;

/** 清空栈内元素 */
- (void)clear;

@end

NS_ASSUME_NONNULL_END
