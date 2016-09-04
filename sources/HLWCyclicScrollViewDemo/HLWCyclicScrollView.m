//
//  HLWCyclicScrollView.m
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/1/1.
//  Copyright © 2016年 tang. All rights reserved.
//

#import "HLWCyclicScrollView.h"
#import "UIView+CopyView.h"
#import "HLWDoubleLinkedCircularList.h"

@interface HLWCyclicScrollView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * scrollView;

@property (strong, nonatomic) UIView * leftView;
@property (strong, nonatomic) UIView * middleView;
@property (strong, nonatomic) UIView * rightView;

@property (strong, nonatomic) HLWDoubleWayNode * leftNode;
@property (strong, nonatomic) HLWDoubleWayNode * middleNode;
@property (strong, nonatomic) HLWDoubleWayNode * rightNode;

@property (strong, nonatomic) HLWDoubleLinkedCircularList * list;

@end


@implementation HLWCyclicScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect scrollViewFrame = frame;
        scrollViewFrame.origin = CGPointZero;
        _scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
        _scrollView.contentSize = CGSizeMake(3 * frame.size.width, frame.size.height);
        
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        
        [self addSubview:_scrollView];
        
        _scrollView.delegate = self;
        
        [self setupDataStruct];
        [self initLeftMiddleRightNodes];
        [self setContentViews];
        
        [self layoutContentViews];
    }
    return self;
}

-(UIView *)leftView
{
    if (!_leftView) {
        _leftView = [UIView new];
    }
    return _leftView;
}

-(UIView *)middleView
{
    if (!_middleView) {
        _middleView = [UIView new];
    }
    return _middleView;
}

-(UIView *)rightView
{
    if (!_rightView) {
        _rightView = [UIView new];
    }
    return _rightView;
}

- (void)setupDataStruct
{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    [dataArray addObject:[UIColor redColor]];
    [dataArray addObject:[UIColor greenColor]];
    [dataArray addObject:[UIColor blueColor]];
    _list = [HLWDoubleLinkedCircularList doubleLinkedCircularListWithArray:dataArray];
}

- (void)initLeftMiddleRightNodes
{
    _middleNode = _list.head;
    _leftNode = _middleNode.previous;
    _rightNode = _middleNode.next;
}

- (void)previousTurn
{
    _middleNode = _middleNode.previous;
    _leftNode = _middleNode.previous;
    _rightNode = _middleNode.next;
}

- (void)nextTurn
{
    _middleNode = _middleNode.next;
    _leftNode = _middleNode.previous;
    _rightNode = _middleNode.next;
}

- (void)layoutContentViews
{
    self.leftView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.middleView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    self.rightView.frame = CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height);
}

- (void)setContentViews
{
    [self removeContentViews];
    [self configContentViews];
    [self addContentViews];
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);

    NSLog(@"current index: %lu", (unsigned long)_middleNode.index);
}

- (void)configContentViews
{
    self.leftView.backgroundColor = (UIColor *)_leftNode.data;
    self.middleView.backgroundColor = (UIColor *)_middleNode.data;
    self.rightView.backgroundColor = (UIColor *)_rightNode.data;
}

- (void)addContentViews
{
    [self.scrollView addSubview:self.leftView];
    [self.scrollView addSubview:self.middleView];
    [self.scrollView addSubview:self.rightView];
}

- (void)removeContentViews
{
    [self.leftView removeFromSuperview];
    [self.middleView removeFromSuperview];
    [self.rightView removeFromSuperview];

}



#pragma mark - ---------- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
    CGPoint offset = scrollView.contentOffset;
    CGFloat pageIndex = offset.x / self.frame.size.width;
    
    if (0 >= pageIndex) {
        // 左划，因为页面从中间页划到了第一页；
        [self previousTurn];
        [self setContentViews];
        
    } else if (1 == pageIndex) {
        // 没划，因为页面还是中间页；
        
    } else if (2 <= pageIndex) {
        // 右划，因为页面从中间页划到了第三页；
        [self nextTurn];
        [self setContentViews];
    }
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%s", __func__);
}

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
}

- (void)dealloc
{
    NSLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

@end
