//
//  HLWCyclicScrollView.h
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/8/31.
//  Copyright © 2016年 tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WHcrollViewViewDelegate;

@interface HLWCyclicScrollView1 : UIView
{
    __unsafe_unretained id  _delegate;
}

@property (nonatomic, assign) id  delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;

-(void)shouldAutoShow:(BOOL)shouldStart;

@end

@protocol WHcrollViewViewDelegate

@optional
- (void)didClickPage:(HLWCyclicScrollView1 *)view atIndex:(NSInteger)index;

@end
