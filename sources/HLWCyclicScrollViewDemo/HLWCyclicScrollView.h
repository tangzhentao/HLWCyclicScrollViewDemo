//
//  HLWCyclicScrollView.h
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/1/1.
//  Copyright © 2016年 tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PageControlPosition)
{
    PageControlPositionRight = 0,
    PageControlPositionMiddle = 1,
    PageControlPositionLeft = 2,
    
};

@interface HLWCyclicScrollView : UIView

/*
 用于自定义pageControl的颜色
 */
@property (strong, nonatomic, readonly) UIPageControl * pageControl;

@property (assign, nonatomic) PageControlPosition pageControlPosition;
@property (assign, nonatomic) CGFloat pageControlSpace;

@property (strong, nonatomic) NSMutableArray * contentArray;

@property (strong, nonatomic) NSString * placeholderImageName; // 站位图


@end

/*
 @protocol HLWCyclicScrollViewDelegate <NSObject>
 
 - (NSInteger)numberOfPagesInCyclicScrollView:(HLWCyclicScrollView *)cyclicScrollView;
 - (id)cyclicScrollView:(HLWCyclicScrollView *)cyclicScrollView contentOfPageAtIndex:(NSUInteger)index;
 
 @end
 */



