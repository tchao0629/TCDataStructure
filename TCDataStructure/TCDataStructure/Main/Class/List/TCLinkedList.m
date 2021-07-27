//
//  TCLinkedList.m
//  MyTest
//
//  Created by tangchao on 2021/7/2.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCLinkedList.h"

@interface TCLinkedListNode<TCElement> : NSObject {
    TCElement _element;
    TCLinkedListNode<TCElement> *_prev;
    TCLinkedListNode<TCElement> *_next;
}

@property (nonatomic, strong) TCElement element;
@property (nonatomic, strong) TCLinkedListNode<TCElement> *prev;
@property (nonatomic, strong) TCLinkedListNode<TCElement> *next;

- (instancetype)initWithElement:(TCElement)element withPrev:(nullable TCLinkedListNode<TCElement> *)prev andNext:(nullable TCLinkedListNode<TCElement> *)next;

@end

@implementation TCLinkedListNode

- (instancetype)initWithElement:(id)element withPrev:(TCLinkedListNode *)prev andNext:(TCLinkedListNode *)next {
    if (self = [super init]) {
        self.element = element;
        self.prev = prev;
        self.next = next;
    }
    return self;
}

@end

@interface TCLinkedList<TCElement> () {
    /// 头节点
    TCLinkedListNode<TCElement> *_first;
    /// 尾节点
    TCLinkedListNode<TCElement> *_last;
}

/**
 * 检测index是否合法
 */
- (BOOL)checkIndex:(int)index;

/// 检测元素不为nil
- (BOOL)checkElementNotNull:(TCElement)element;
/// 查找节点根据index
- (TCLinkedListNode<TCElement> *)nodeForIndex:(int)index;

@end

@implementation TCLinkedList

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
    if (!element) return ELEMENT_NOT_FOUND;
    
    TCLinkedListNode *node = _first;
    for (int i = 0; i < _size; i++) {
        if ([node.element isEqual:element]) {
            return i;
        }
        node = node.next;
    }
    return ELEMENT_NOT_FOUND;
}

- (void)addElement:(id)element forIndex:(int)index {
    if (![self checkElementNotNull:element]) return ;
    if (index < 0 || index > _size) {
        NSAssert(index >= 0 && index <= _size, @"index error.");
        return ;
    }
    
    if (index == _size) { /// 添加到尾部
        TCLinkedListNode *oldLast = _last;
        _last = [[TCLinkedListNode alloc] initWithElement:element withPrev:oldLast andNext:nil];
        if (oldLast) {
            oldLast.next = _last;
        } else { /// 第一次添加元素
            _first = _last;
        }
    } else {
        TCLinkedListNode *next = [self nodeForIndex:index];
        TCLinkedListNode *prev = next.prev;
        TCLinkedListNode *node = [[TCLinkedListNode alloc] initWithElement:element withPrev:prev andNext:next];
        next.prev = node;
        if (prev) {
            prev.next = node;
        } else { /// index = 0
            _first = node;
        }
    }
    _size++;
}

- (id)removeElementForIndex:(int)index {
    if (![self checkIndex:index]) {
#if DEBUG
        NSLog(@"remove fail, element not found.");
#endif
        return nil;
    }
    
    TCLinkedListNode *node = [self nodeForIndex:index];
    TCLinkedListNode *prev = node.prev;
    TCLinkedListNode *next = node.next;
    
    if (prev) {
        prev.next = next;
    } else {
        _first = next;
    }
    
    if (next) {
        next.prev = prev;
    } else {
        _last = prev;
    }
    _size--;
    
    return node.element;
}
- (id)setElement:(id)element forIndex:(int)index {
    if (![self checkElementNotNull:element]) return nil;
    if (![self checkIndex:index]) return nil;
    
    TCLinkedListNode *node = [self nodeForIndex:index];
    id old = node.element;
    node.element = element;
    
    return old;
}
- (id)getElementForIndex:(int)index {
    return [self nodeForIndex:index].element;
}

#pragma mark - Private Methods
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
- (TCLinkedListNode *)nodeForIndex:(int)index {
    if (![self checkIndex:index]) return nil;
    
    if (index < (_size >> 1)) { /// 前半段
        TCLinkedListNode *node = _first;
        for (int i = 0; i < index; i++) {
            node = node.next;
        }
        return node;
    } else { /// 后半段
        TCLinkedListNode *node = _last;
        for (int i = _size-1; i > index; i--) {
            node = node.prev;
        }
        return node;
    }
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendFormat:@"size = %d, ", _size];
    TCLinkedListNode *node = _first;
    for (int i = 0; i < _size; i++) {
        [string appendFormat:@"[%@_%@_%@]", node.prev.element, node.element, node.next.element];
        if (i != _size-1) {
            [string appendString:@"->"];
        }
        node = node.next;
    }
    
    return [NSString stringWithString:string];
}

@end
