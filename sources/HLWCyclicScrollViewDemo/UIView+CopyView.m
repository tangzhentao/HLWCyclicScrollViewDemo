//
//  UIView+CopyView.m
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/9/1.
//  Copyright © 2016年 tang. All rights reserved.
//

#import "UIView+CopyView.h"

@implementation UIView (CopyView)

- (UIView *)copyView
{
    NSData *viewData = [NSKeyedArchiver archivedDataWithRootObject:self];
    UIView *view = [NSKeyedUnarchiver unarchiveObjectWithData:viewData];
    
    return view;
}

@end
