//
//  HLWCyclicViewController.h
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/9/2.
//  Copyright © 2016年 tang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PageControlPosition)
{
    PageControlPositionRight = 0,
    PageControlPositionMiddle = 1,
    PageControlPositionLeft = 2,

};

@interface HLWCyclicViewController : UIViewController

/*!
 array中可包含：图片名、图片网址和UIImage。
 */
+ (id)cyclicViewControllerWithArray:(NSArray *)array;

@property (strong, nonatomic) NSArray *array;

@property (strong, nonatomic, readonly) UIPageControl * pageControl;
@property (assign, nonatomic) PageControlPosition pageControlPosition;
@property (assign, nonatomic) CGFloat pageControlSpace;


- (void)show;

@end
