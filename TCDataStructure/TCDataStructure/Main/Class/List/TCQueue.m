//
//  TCQueue.m
//  test
//
//  Created by tangchao on 2021/7/10.
//  Copyright © 2021年 tangchao. All rights reserved.
//

#import "TCQueue.h"
#import "TCLinkedList.h"

@interface TCQueue<TCElement> () {
    TCLinkedList<TCElement> *_list;
}

@end

@implementation TCQueue

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

-(void)enQueue:(id)element {
    [_list addElement:element];
}
- (id)deQueue {
    if ([_list isEmpty]) {
        return nil;
    }
    
    return [_list removeElementForIndex:0];
}

- (id)front {
    if ([_list isEmpty]) {
        return nil;
    }
    return [_list getElementForIndex:0];
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{"];
    int size = _list.size;
    for (int i = 0; i < size; i++) {
        [string appendFormat:@"%@", [_list getElementForIndex:i]];
        if (i != size-1) {
            [string appendString:@",\n"];
        }
    }
    [string appendString:@"}"];
    
    return [NSString stringWithString:string];
}

@end
