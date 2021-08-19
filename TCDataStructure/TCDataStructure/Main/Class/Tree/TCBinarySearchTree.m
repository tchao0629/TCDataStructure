//
//  TCBinarySearchTree_05.m
//  Test
//
//  Created by tangchao on 2021/8/14.
//  Copyright © 2021 Midas. All rights reserved.
//

#import "TCBinarySearchTree.h"
#import "TCComparable.h"

@interface TCBinarySearchTree<TCElement> ()

@property (nonatomic, copy) int (^comparator)(TCElement e1, TCElement e2);

- (NSInteger)compare:(TCElement)e1 to:(TCElement)e2;

- (TCBinaryTreeNode *)nodeForElement:(TCElement)element;
- (void)removeNode:(TCBinaryTreeNode *)node;

@end

@implementation TCBinarySearchTree

- (instancetype)initWithComparator:(int (^)(id _Nonnull, id _Nonnull))comparator {
    if (self = [super init]) {
        self.comparator = comparator;
    }
    return self;
}

- (BOOL)contains:(id)element {
    return [self nodeForElement:element] != nil;
}

- (__kindof TCBinaryTreeNode *)createNodeWithElement:(id)element andParant:(__kindof TCBinaryTreeNode *)parent {
    return [[TCBinaryTreeNode alloc] initWithElement:element andParent:parent];
}

- (void)add:(id)element {
    if (![self checkElementNotNull:element]) {
        return;
    }
    
    if (!_root) {
        _root = [self createNodeWithElement:element andParant:nil];
        _size++;
        [self afterAdd:_root];
        return;
    }
    
    TCBinaryTreeNode *node = _root;
    /// 记录父节点
    TCBinaryTreeNode *parent = _root;
    /// 记录添加位置
    NSInteger cmp = 0;
    do {
        parent = node;
        cmp = [self compare:element to:node.element];
        if (cmp == TCNotCompare) {
#if DEBUG
                NSLog(@"add fail, 元素无法比较.");
                
#endif
            return ;
        }
        
        if (cmp == 0) {
            node.element = element;
            return;
        } else if (cmp > 0) {
            node = node.right;
        } else { /// cmp < 0
            node = node.left;
        }
    } while (node);
    
    TCBinaryTreeNode *newNode = [self createNodeWithElement:element andParant:parent];
    if (cmp > 0) {
        parent.right = newNode;
    } else {
        parent.left = newNode;
    }
    _size++;
    [self afterAdd:newNode];
}
- (void)afterAdd:(__kindof TCBinaryTreeNode *)node {
    /// 子类去重写
}
- (void)afterRemove:(__kindof TCBinaryTreeNode *)node {
    /// 子类去重写
}
- (id)remove:(id)element {
    TCBinaryTreeNode *node = [self nodeForElement:element];
    if (node) {
        [self removeNode:node];
        
        [self afterRemove:node];
        return node.element;
    }
    return node;
}
- (void)removeNode:(TCBinaryTreeNode *)node {
    if (!node) {
        return;
    }
    
    if ([node hasTwoChild]) {
        TCBinaryTreeNode *suc = [self successor:node];
        node.element = suc.element;
        node = suc;
    }
    
    TCBinaryTreeNode *replacement = node.left ? node.left : node.right;
    if (replacement) {
        replacement.parent = node.parent;
    }
    
    if (!node.parent) {
        _root = replacement;
    } else if (node == node.parent.left) {
        node.parent.left = replacement;
    } else { /// node == node.parent.right
        node.parent.right = replacement;
    }
    _size--;
}

- (NSInteger)compare:(id)e1 to:(id)e2 {
    if (self.comparator) {
        return self.comparator(e1, e2);
    } else {
        if ([e1 conformsToProtocol:@protocol(TCComparable)]) {
            if ([e1 respondsToSelector:@selector(tc_compare:)]) {
                return [e1 tc_compare:e2];
            } else {
                return TCNotCompare;
            }
        } else {
            return TCNotCompare;
        }
    }
}

- (TCBinaryTreeNode *)nodeForElement:(id)element {
    if (![self nodeForElement:element]) {
        return nil;
    }
    
    TCBinaryTreeNode *node = _root;
    while (node) {
        NSInteger cmp = [self compare:element to:node.element];
        if (cmp == TCNotCompare) {
            return nil;
        }
        
        if (cmp == 0) {
            return node;
        } else if (cmp > 0) {
            node = node.right;
        } else { /// cmp < 0
            node = node.left;
        }
    }
    
    return node;
}

@end
