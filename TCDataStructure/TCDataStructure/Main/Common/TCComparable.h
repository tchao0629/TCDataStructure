//
//  TCComparable.h
//  Test
//
//  Created by tangchao on 2021/8/14.
//  Copyright © 2021 Midas. All rights reserved.
//

#ifndef TCComparable_h
#define TCComparable_h

/// 无法比较
static const NSInteger TCNotCompare = NSIntegerMax;

/// 比较协议
@protocol TCComparable <NSObject>

- (int)tc_compare:(id)obj;

@end


#endif /* TCComparable_h */
