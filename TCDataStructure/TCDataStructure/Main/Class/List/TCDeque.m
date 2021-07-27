//
//  TCDeque.m
//  TCDataStructure
//
//  Created by tangchao on 2021/7/12.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCDeque.h"
#import "TCLinkedList.h"

@interface TCDeque<TCElement> () {
    TCLinkedList<TCElement> *_list;
}

@end

@implementation TCDeque

- (instancetype)init {
    self = [super init];
    if (self) {
        _list = [[TCLinkedList alloc] init];
    }
    return self;
}

- (int)size {
    return _list.size;
}
- (BOOL)isEmpty {
    return [_list isEmpty];
}
- (void)clear {
    [_list clear];
}

- (void)enQueueRear:(id)element {
    [_list addElement:element];
}
- (id)deQueueFront {
    if ([_list isEmpty]) {
        return nil;
    }
    return [_list removeElementForIndex:0];
}
- (void)enQueueFront:(id)element {
    [_list addElement:element forIndex:0];
}
- (id)deQueueRear {
    if ([_list isEmpty]) {
        return nil;
    }
    return [_list removeElementForIndex:_list.size-1];
}

- (id)front {
    if ([_list isEmpty]) {
        return nil;
    }
    return [_list getElementForIndex:0];
}
- (id)rear {
    if ([_list isEmpty]) {
        return nil;
    }
    return [_list getElementForIndex:_list.size-1];
}

- (NSString *)description {
    NSMutableString *string = [[NSMutableString alloc] init];
    int size = _list.size;
    for (int i = 0; i < size; i++) {
        [string appendFormat:@"[%@]", [_list getElementForIndex:i]];
        if (i != size-1) {
            [string appendString:@"->"];
        }
    }
    return [NSString stringWithString:string];
}

@end
