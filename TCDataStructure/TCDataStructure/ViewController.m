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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self singleLinkTest];
    [self test];
}
- (void)test {
    TCLinkedList *list = [[TCLinkedList alloc] init];
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
    //    [list removeElement:@(3)];
    //    [list removeElementForIndex:list.size-1];
    //    [list removeElementForIndex:list.size];
    
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
