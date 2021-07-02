//
//  TCSingleLinkedList.m
//  TCDataStructure
//
//  Created by tangchao on 2021/7/2.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCSingleLinkedList.h"

@interface TCSingleLinkedListNode <TCElement> : NSObject {
    @protected
    TCElement _element;
    TCSingleLinkedListNode<TCElement> *_next;
}

@property (nonatomic, strong) TCElement element;
@property (nonatomic, strong) TCSingleLinkedListNode<TCElement> *next;

/// 初始化
- (instancetype)initWithElement:(TCElement)element andNext:(nullable TCSingleLinkedListNode<TCElement> *)next;

@end

@implementation TCSingleLinkedListNode

- (instancetype)initWithElement:(id)element andNext:(TCSingleLinkedListNode *)next {
    if (self = [super init]) {
        _element = element;
        _next = next;
    }
    return self;
}

@end

@interface TCSingleLinkedList<TCElement> () {
    TCSingleLinkedListNode<TCElement> *_first;
}

/// 检测元素是否为空
- (BOOL)checkElementNotNull:(TCElement)element;

/**
 * 根据index查找node
 */
- (TCSingleLinkedListNode<TCElement> *)nodeForIndex:(int)index;
/**
 * 检测index是否合法
 */
- (BOOL)checkIndex:(int)index;

@end

@implementation TCSingleLinkedList

- (instancetype)init {
    self = [super init];
    if (self) {
        _first = nil;
    }
    return self;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (void)clear {
    [super clear];
    _first = nil;
}

- (void)addElement:(id)element forIndex:(int)index {
    /**
     * 最好：O(1)
     * 最坏：O(n)
     * 平均：O(n)
     */
    
    if (![self checkElementNotNull:element]) return ;
    /// 检测 index
    if (index < 0 || index > _size) {
        NSAssert(index >= 0 && index <= _size, @"index error.");
        return ;
    }
    
    if (index == 0) { /// 添加到头节点
        _first = [[TCSingleLinkedListNode alloc] initWithElement:element andNext:_first];
    } else {
        TCSingleLinkedListNode *prev = [self nodeForIndex:index-1];
        prev.next = [[TCSingleLinkedListNode alloc] initWithElement:element andNext:prev.next];
    }
    _size ++;
}

- (id)removeElementForIndex:(int)index {
    /**
     * 最好：O(1)
     * 最坏：O(n)
     * 平均：O(n)
     */
    if (![self checkIndex:index]) return nil;
   
    TCSingleLinkedListNode *node = _first;
    if (index == 0) { /// 删除第一个节点
        _first = _first.next;
    } else {
        TCSingleLinkedListNode *prev = [self nodeForIndex:index-1];
        node = prev.next;
        prev.next = node.next;
    }

     _size --;
    return node.element;
}

- (id)setElement:(id)element forIndex:(int)index {
    /**
     * 最好：O(1)
     * 最坏：O(n)
     * 平均：O(n)
     */
    if (![self checkElementNotNull:element]) return nil;
    
    TCSingleLinkedListNode *node = [self nodeForIndex:index];
    if (!node) return nil;
    
    id oldElement = node.element;
    node.element = element;
    
    return oldElement;
}
- (id)getElementForIndex:(int)index {
    /**
     * 最好：O(1)
     * 最坏：O(n)
     * 平均：O(n)
     */
    TCSingleLinkedListNode *node = [self nodeForIndex:index];
    return node.element;
}

- (int)indexOf:(id)element {
    if (![self checkElementNotNull:element]) return ELEMENT_NOT_FOUND;
    
    TCSingleLinkedListNode *node = _first;
    for (int i = 0; i < _size; i++) {
        if ([node.element isEqual:element]) {
            return i;
        }
        node = node.next;
    }
    
    return ELEMENT_NOT_FOUND;
}

#pragma mark - Private Methods
- (TCSingleLinkedListNode *)nodeForIndex:(int)index {
    if (![self checkIndex:index]) return nil;
    
    TCSingleLinkedListNode *node = _first;
    for (int i = 0; i < index; i++) {
        node = node.next;
    }
    return node;
}

- (BOOL)checkIndex:(int)index {
    if (index < 0 || index >= _size) {
        NSAssert(index >= 0 && index < _size, @"index error.");
        return NO;
    }
    return YES;
}
- (BOOL)checkElementNotNull:(id)element {
    if (!element) {
        NSAssert(element, @"element is nil.");
        return NO;
    }
    return YES;
}

- (NSString *)description {
    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:@"size = %d, ", _size];
    TCSingleLinkedListNode *node = _first;
    for (int i = 0; i < _size; i++) {
        [desc appendFormat:@"[%@]", node.element];
        if (i != _size-1) {
            [desc appendString:@"->"];
        }
        node = node.next;
    }
    
    return [NSString stringWithString:desc];
}

@end
