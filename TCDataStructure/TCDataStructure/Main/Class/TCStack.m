//
//  TCStack.m
//  TCDataStructure
//
//  Created by tangchao on 2021/6/18.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "TCStack.h"

@interface TCStack ()

@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation TCStack

- (instancetype)init {
    self = [super init];
    if (self) {
        _list = [[NSMutableArray alloc] initWithCapacity:4];
        _size = 0;
    }
    return self;
}

- (BOOL)isEmpty {
    return self.list.count == 0;
}

- (void)push:(id)element {
    [self.list addObject:element];
    _size = self.list.count;
}

- (id)pop {
    id element = [self.list lastObject];
    [self.list removeLastObject];
    _size = self.list.count;
    
    return element;
}

- (id)top {
    return [self.list lastObject];
}

- (void)clear {
    [self.list removeAllObjects];
    _size = self.list.count;
}


@end
