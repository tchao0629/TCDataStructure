//
//  ViewController.m
//  TCDataStructure
//
//  Created by tangchao on 2021/6/18.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "ViewController.h"
#import "TCSingleLinkedList.h"
#import "TCLinkedList.h"
#import "TCCircleLinkedList.h"
#import "TCStack.h"
#import "TCQueue.h"
#import "TCDeque.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self singleLinkTest];
//    [self test];
//    [self stackTest];
//    [self queueTest];
    [self dequeTest];
}
- (void)dequeTest {
    TCDeque *object = [[TCDeque alloc] init];
    
    NSLog(@"isEmpty : %d", [object isEmpty]);
    NSLog(@"size = %d", object.size);
    NSLog(@"front : %@", [object front]);
    NSLog(@"rear : %@", [object rear]);
    
    /// push
    NSLog(@"deQueueFront : %@", [object deQueueFront]);
    NSLog(@"deQueueRear : %@", [object deQueueRear]);
    [object enQueueRear:@(2)];
    NSLog(@"top : %@", [object front]);
    NSLog(@"pop : %@", [object deQueueFront]);
    [object enQueueRear:@(3)];
    [object enQueueRear:@(5)];
    NSLog(@"front : %@", [object front]);
    NSLog(@"rear : %@", [object rear]);
    [object enQueueFront:@(2)];
    NSLog(@"front : %@", [object front]);
    NSLog(@"rear : %@", [object rear]);
    NSLog(@"deQueueFront : %@", [object deQueueFront]);
    NSLog(@"deQueueRear : %@", [object deQueueRear]);
    [object enQueueRear:@"123"];
    
    NSLog(@"isEmpty : %d", [object isEmpty]);
    NSLog(@"size = %d", object.size);
    NSLog(@"%@", object);
    
    [object clear];
    
    NSLog(@"isEmpty : %d", [object isEmpty]);
    NSLog(@"size = %d", object.size);
    NSLog(@"%@", object);
}
- (void)queueTest {
    TCQueue *queue = [[TCQueue alloc] init];
    NSLog(@"size : %d", queue.size);
    NSLog(@"isEmpty : %d", [queue isEmpty]);
    NSLog(@"front: %@", [queue front]);
    NSLog(@"dequeue: %@", [queue deQueue]);
    
    [queue enQueue:@(2)];
    NSLog(@"size : %d", queue.size);
    NSLog(@"isEmpty : %d", [queue isEmpty]);
    NSLog(@"front: %@", [queue front]);
    //    NSLog(@"dequeue: %@", [queue deQueue]);
    
    [queue enQueue:@(3)];
    [queue enQueue:@(5)];
    NSLog(@"size : %d", queue.size);
    NSLog(@"isEmpty : %d", [queue isEmpty]);
    NSLog(@"front: %@", [queue front]);
    NSLog(@"dequeue: %@", [queue deQueue]);
    
    NSLog(@"%@", queue);
    
    [queue clear];
    NSLog(@"size : %d", queue.size);
    NSLog(@"isEmpty : %d", [queue isEmpty]);
    NSLog(@"front: %@", [queue front]);
    NSLog(@"dequeue: %@", [queue deQueue]);
    
    NSLog(@"%@", queue);
    
}
- (void)stackTest {
    TCStack *stack = [[TCStack alloc] init];
    NSLog(@"isEmpty : %d", [stack isEmpty]);
    NSLog(@"size = %d", stack.size);
    NSLog(@"top : %@", [stack top]);
    
    /// push
    NSLog(@"pop : %@", [stack pop]);
    [stack push:@(2)];
    NSLog(@"top : %@", [stack top]);
    NSLog(@"pop : %@", [stack pop]);
    [stack push:@(3)];
    [stack push:@(5)];
    NSLog(@"top : %@", [stack top]);
    NSLog(@"pop : %@", [stack pop]);
    [stack push:@"123"];
    
    NSLog(@"isEmpty : %d", [stack isEmpty]);
    NSLog(@"size = %d", stack.size);
    NSLog(@"%@", stack);
    
    [stack clear];
    
    NSLog(@"isEmpty : %d", [stack isEmpty]);
    NSLog(@"size = %d", stack.size);
    NSLog(@"%@", stack);
}

- (void)test {
    TCCircleLinkedList *list = [[TCCircleLinkedList alloc] init];
    NSLog(@"isEmpty: %d", list.isEmpty);
    NSLog(@"@(1) index : %d", [list indexOf:@(1)]);
    NSLog(@"contains @(1) : %d", [list contains:@(1)]);
    [list removeElement:@(1)];
    
    /// add
    [list addElement:@(2)];
    [list addElement:@(3)];
    [list addElement:@(5)];
    //    NSLog(@"@(1) index : %d", [list indexOf:@(1)]);
    //    NSLog(@"contains @(1) : %d", [list contains:@(1)]);
    //    NSLog(@"@(2) index : %d", [list indexOf:@(2)]);
    //    NSLog(@"contains @(2) : %d", [list contains:@(2)]);
    NSLog(@"@(3) index : %d", [list indexOf:@(3)]);
    NSLog(@"contains @(3) : %d", [list contains:@(3)]);
    NSLog(@"@\"2\" index : %d", [list indexOf:@"2"]);
    NSLog(@"contains @\"2\" : %d", [list contains:@"2"]);
    [list addElement:@(100) forIndex:0];
    [list removeElementForIndex:0];
    
    /// remove
//        [list removeElement:@(3)];
//        [list removeElementForIndex:list.size-1];
//        [list removeElementForIndex:list.size];
    
    NSLog(@"set [0] %@", [list setElement:@(100) forIndex:0]);
    NSLog(@"get [0] %@", [list getElementForIndex:0]);
    
    NSLog(@"isEmpty: %d", list.isEmpty);
    NSLog(@"%@", list);
    
    [list clear];
    NSLog(@"isEmpty: %d", list.isEmpty);
    NSLog(@"%@", list);
}

- (void)singleLinkTest {
//    TCSingleLinkedList<NSString *> *list = [[TCSingleLinkedList alloc] init];
//    list addElement:<#(nonnull NSString *)#>
    
    TCSingleLinkedList *list = [[TCSingleLinkedList alloc] init];
    NSLog(@"list isEmpty : %d", [list isEmpty]);
    NSLog(@"list contains @(2) : %d", [list contains:@(2)]);
    NSLog(@"@(2) index : %d", [list indexOf:@(2)]);
    [list removeElement:@1];
    
    [list addElement:@(2)];
    NSLog(@"list contains @(2) : %d", [list contains:@(2)]);
    NSLog(@"@(2) index : %d", [list indexOf:@(2)]);
    NSLog(@"list contains @\"2\" : %d", [list contains:@"2"]);
    
    [list addElement:@(3)];
    [list addElement:@(5)];
//    [list addElement:@(100) forIndex:4];
    
    /// remove
//    [list removeElement:@(5)];
//    [list removeElement:@(3)];
//    [list removeElement:@(2)];
    /// size = 0
//    [list removeElement:@(2)];
//    [list removeElementForIndex:3];
    
    /// get
//    NSLog(@"%@", [list getElementForIndex:3]);
    
    /// set
    NSLog(@"set [0] old : %@", [list setElement:@(100) forIndex:0]);
    NSLog(@"set [0] new : %@", [list getElementForIndex:0]);
    
    NSLog(@"list isEmpty : %d", [list isEmpty]);
    NSLog(@"%@", list);
    
    /// clear
    [list clear];
    NSLog(@"%@", list);
}


@end
