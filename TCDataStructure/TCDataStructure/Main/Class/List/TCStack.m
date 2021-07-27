//
//  TCStack.m
//  TCDataStructure
//
//  Created by tangchao on 2021/6/18.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCStack.h"

@interface TCStack<TCElement> () {
    NSMutableArray<TCElement> *_array;
}

@end

@implementation TCStack

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [[NSMutableArray alloc] initWithCapacity:2];
    }
    return self;
}

- (int)size {
    return (int)_array.count;
}

- (BOOL)isEmpty {
    return _array.count == 0;
}

- (void)push:(id)element {
    if (element) {
        [_array addObject:element];
    }
}

- (id)pop {
    id element = [_array lastObject];
    if (element) {
        [_array removeLastObject];
    }
    return element;
}

- (id)top {
    return [_array lastObject];
}

- (void)clear {
    [_array removeAllObjects];
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    int size = (int)_array.count;
    [string appendFormat:@"size = %d, ", size];
    for (int i = 0; i < size; i++) {
        [string appendFormat:@"[%@]", _array[i]];
        if (i != size-1) {
            [string appendString:@"->"];
        }
    }
    
    return [NSString stringWithString:string];
}

@end
