//
//  TCSingleCircleLinkedList.m
//  MyTest
//
//  Created by tangchao on 2021/7/6.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCSingleCircleLinkedList.h"

@interface TCSingleCircleLinkedListNode<TCElement> : NSObject {
    @public
    TCElement _element;
    TCSingleCircleLinkedListNode<TCElement> *_next;
}

- (instancetype)initWithElement:(TCElement)element andNext:(nullable TCSingleCircleLinkedListNode<TCElement> *)next;

@end

@implementation TCSingleCircleLinkedListNode

- (instancetype)initWithElement:(id)element andNext:(TCSingleCircleLinkedListNode *)next {
    if (self = [super init]) {
        _element = element;
        _next = next;
    }
    return self;
}

@end

@interface TCSingleCircleLinkedList<TCElement> () {
    /// 头节点
    TCSingleCircleLinkedListNode<TCElement> *_first;
}

/// 检测元素不为nil
- (BOOL)checkElementNotNull:(TCElement)element;
/// 根据index查找节点
- (TCSingleCircleLinkedListNode<TCElement> *)nodeForIndex:(int)index;
/// 检测index是否合法
- (BOOL)checkIndex:(int)index;

@end

@implementation TCSingleCircleLinkedList

- (instancetype)init {
    self = [super init];
    if (self) {
        _first = nil;
    }
    return self;
}

- (void)clear {
    [super clear];
    _first = nil;
}
- (int)indexOf:(id)element {
    if (!element) return ELEMENT_NOT_FOUND;
    
    TCSingleCircleLinkedListNode *node = _first;
    for (int i = 0; i < _size; i++) {
        if ([node->_element isEqual:element]) {
            return i;
        }
        node = node->_next;
    }
    return ELEMENT_NOT_FOUND;
}

- (void)addElement:(id)element forIndex:(int)index {
    if (![self checkElementNotNull:element]) return ;
    if (index < 0 || index > _size) {
        NSAssert(index >= 0 && index <= _size, @"index error.");
        return ;
    }
    
    if (index == 0) {
        TCSingleCircleLinkedListNode *newFirst = [[TCSingleCircleLinkedListNode alloc] initWithElement:element andNext:_first];
        TCSingleCircleLinkedListNode *last = _size == 0 ? newFirst : [self nodeForIndex:_size-1];
        last->_next = newFirst;
        _first = newFirst;
    } else {
        TCSingleCircleLinkedListNode *prev = [self nodeForIndex:index-1];
        prev->_next = [[TCSingleCircleLinkedListNode alloc] initWithElement:element andNext:prev->_next];
    }
    _size++;
}
- (id)removeElementForIndex:(int)index  {
    if (![self checkIndex:index]) return nil;
    
    TCSingleCircleLinkedListNode *node = _first;
    if (index == 0) {
        if (_size == 1) {
            _first = nil;
        } else {
            TCSingleCircleLinkedListNode *last = [self nodeForIndex:_size-1];
            _first = _first->_next;
            last->_next = _first;
        }
    } else {
        TCSingleCircleLinkedListNode *prev = [self nodeForIndex:index-1];
        node = prev->_next;
        prev->_next = node->_next;
    }
    _size--;
    return node->_element;
}
- (id)setElement:(id)element forIndex:(int)index {
    if (![self checkElementNotNull:element]) return nil;
    if (![self checkIndex:index]) return nil;
    
    TCSingleCircleLinkedListNode *node = [self nodeForIndex:index];
    id old = node->_element;
    node->_element = element;
    
    return old;
}
- (id)getElementForIndex:(int)index {
    TCSingleCircleLinkedListNode *node = [self nodeForIndex:index];
    if (node) {
        return node->_element;
    }
    return nil;
}

#pragma mark - Private Methods
- (BOOL)checkElementNotNull:(id)element {
    if (element) return YES;
    NSAssert(element, @"element is nil.");
    return NO;
}
- (TCSingleCircleLinkedListNode *)nodeForIndex:(int)index {
    if (![self checkIndex:index]) return nil;
    
    TCSingleCircleLinkedListNode *node = _first;
    for (int i = 0; i < index; i++) {
        node = node->_next;
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

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"size = %d, ", _size];
    
    TCSingleCircleLinkedListNode *node = _first;
    for (int i = 0; i < _size; i++) {
        [string appendFormat:@"[%@_%@]", node->_element, node->_next?node->_next->_element:node->_next];
        if (i != _size-1) {
            [string appendString:@"->"];
        }
        node = node->_next;
    }
    
    return [NSString stringWithString:string];
}

@end
