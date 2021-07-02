//
//  TCAbstractList.m
//  TCDataStructure
//
//  Created by tangchao on 2021/7/2.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCAbstractList.h"

int const  ELEMENT_NOT_FOUND = -1;

@implementation TCAbstractList

- (instancetype)init {
    self = [super init];
    if (self) {
        _size = 0;
    }
    return self;
}

- (int)size {
    return _size;
}

- (void)clear {
    _size = 0;
}

- (BOOL)isEmpty {
    return _size == 0;
}

- (BOOL)contains:(id)element {
    return [self indexOf:element] != ELEMENT_NOT_FOUND;
}

- (void)addElement:(id)element {
    [self addElement:element forIndex:_size];
}

- (void)addElement:(id)element forIndex:(int)index {
    /// 子类去实现
}
- (id)setElement:(id)element forIndex:(int)index {
    /// 子类去实现
    return nil;
}
- (id)getElementForIndex:(int)index {
    /// 子类去实现
    return nil;
}
- (id)removeElement:(id)element {
    int index = [self indexOf:element];
    if (index == ELEMENT_NOT_FOUND) return nil;
    
    return [self removeElementForIndex:index];
}
- (id)removeElementForIndex:(int)index {
    /// 子类去实现
    return nil;
}
- (int)indexOf:(id)element {
    return ELEMENT_NOT_FOUND;
}


@end
