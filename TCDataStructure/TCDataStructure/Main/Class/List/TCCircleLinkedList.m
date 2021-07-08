//
//  TCCircleLinkedList.m
//  TCDataStructure
//
//  Created by tangchao on 2021/7/8.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCCircleLinkedList.h"

@interface TCCircleLinkedListNode<TCElement> : NSObject {
    @public
    TCElement _element;
    TCCircleLinkedListNode<TCElement> *_prev;
    TCCircleLinkedListNode<TCElement> *_next;
}

- (instancetype)initWithElement:(TCElement)element withPrev:(nullable TCCircleLinkedListNode<TCElement> *)prev andNext:(nullable TCCircleLinkedListNode<TCElement> *)next;

@end

@implementation TCCircleLinkedListNode

- (instancetype)initWithElement:(id)element withPrev:(TCCircleLinkedListNode *)prev andNext:(TCCircleLinkedListNode *)next {
    if (self = [super init]) {
        _element = element;
        _prev = prev;
        _next = next;
    }
    return self;
}

@end

@interface TCCircleLinkedList<TCElement> () {
    @private
    /// 头节点
    TCCircleLinkedListNode<TCElement> *_first;
    /// 尾节点
    TCCircleLinkedListNode<TCElement> *_last;
    /// 当前节点
    TCCircleLinkedListNode<TCElement> *_current;
}

/// 根据index查找节点
- (TCCircleLinkedListNode<TCElement> *)nodeForIndex:(int)index;

@end

@implementation TCCircleLinkedList

- (instancetype)init {
    self = [super init];
    if (self) {
        _first = nil;
        _last = nil;
    }
    return self;
}

- (void)clear {
    [super clear];
    _first = nil;
    _last = nil;
}

- (int)indexOf:(id)element {
    if (![self checkElementNotNull:element]) return ELEMENT_NOT_FOUND;
    
    TCCircleLinkedListNode *node = _first;
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
    if (![self checkIndexForAdd:index]) return ;
    
    if (index == _size) { /// 往尾部添加元素
        TCCircleLinkedListNode *oldLast = _last;
        _last = [[TCCircleLinkedListNode alloc] initWithElement:element withPrev:oldLast andNext:_first];
        if (oldLast) {
            oldLast->_next = _last;
            _first->_prev = _last;
        } else { /// 第一次添加元素
            _first = _last;
            _first->_next = _first;
            _first->_prev = _first;
        }
    } else {
        TCCircleLinkedListNode *next = [self nodeForIndex:index];
        TCCircleLinkedListNode *prev = next->_prev;
        TCCircleLinkedListNode *node = [[TCCircleLinkedListNode alloc] initWithElement:element withPrev:prev andNext:next];
        next->_prev = node;
        prev->_next = node;
        
        if (next == _first) { /// index = 0
            _first = node;
        }
    }
    _size++;
}

- (id)removeElementForIndex:(int)index {
    if (![self checkIndex:index]) return nil;
    
    TCCircleLinkedListNode *node = [self nodeForIndex:index];
    TCCircleLinkedListNode *prev = node->_prev;
    TCCircleLinkedListNode *next = node->_next;
    prev->_next = next;
    next->_prev = prev;
    
    if (_size == 1) {
        _first = nil;
        _last = nil;
    } else {
        if (node == _first) {
            _first = next;
        }
        if (node == _last) {
            _last = prev;
        }
    }

    _size--;
    
    return node->_element;
}
- (id)setElement:(id)element forIndex:(int)index {
    if (![self checkElementNotNull:element]) return nil;
    if (![self checkIndex:index]) return nil;
    
    TCCircleLinkedListNode *node = [self nodeForIndex:index];
    id old = node->_element;
    node->_element = element;
    
    return old;
}
- (id)getElementForIndex:(int)index {
    TCCircleLinkedListNode *node = [self nodeForIndex:index];
    if (node) {
        return node->_element;
    }
    return nil;
}

- (void)reset {
    _current = _first;
}
- (id)next {
    if (!_current) return nil;
    _current = _current->_next;
    return _current->_element;
}

- (id)remove {
    if (!_current) return nil;
    TCCircleLinkedListNode *next = _current->_next;
    id element = [self removeElement:next->_element];
    
    if (_size == 0) {
        _current = nil;
    } else {
        _current = next;
    }
    
    return element;
}

#pragma mark - Private Methods
- (TCCircleLinkedListNode *)nodeForIndex:(int)index {
    if (![self checkIndex:index]) return nil;
    
    if (index < (_size >> 1)) { /// 前半段
        TCCircleLinkedListNode *node = _first;
        for (int i = 0; i < index; i++) {
            node = node->_next;
        }
        return node;
    } else { /// 后半段
        TCCircleLinkedListNode *node = _last;
        for (int i = _size-1; i > index; i--) {
            node = node->_prev;
        }
        return node;
    }
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"size = %d, ", _size];
    TCCircleLinkedListNode *node = _first;
    for (int i = 0; i < _size; i++) {
        [string appendFormat:@"[%@_%@_%@]", node->_prev?node->_prev->_element:node->_prev, node->_element, node->_next?node->_next->_element:node->_next];
        if (i != _size-1) {
            [string appendString:@"->"];
        }
        node = node->_next;
    }
    
    return [NSString stringWithString:string];
}

@end
