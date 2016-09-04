//
//  HLWCyclicViewController.m
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/9/2.
//  Copyright © 2016年 tang. All rights reserved.
//

#import "HLWCyclicViewController.h"
#import "HLWDoubleLinkedCircularList.h"

@interface HLWCyclicViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIPageControl * pageControl;

@property (strong, nonatomic) HLWDoubleLinkedCircularList * list;
@property (strong, nonatomic) HLWDoubleWayNode * leftNode;
@property (strong, nonatomic) HLWDoubleWayNode * middleNode;
@property (strong, nonatomic) HLWDoubleWayNode * rightNode;

@property (strong, nonatomic) UIImageView * leftImageView;
@property (strong, nonatomic) UIImageView * middleImageView;
@property (strong, nonatomic) UIImageView * rightImageView;

@property (assign, nonatomic) CGFloat viewWidth;
@property (assign, nonatomic) CGFloat viewHeight;

@end

@implementation HLWCyclicViewController

+ (id)cyclicViewControllerWithArray:(NSArray *)array
{
    return [[self alloc] initWithArray:array];
}

- (id)initWithArray:(NSArray *)array
{
    self  = [super init];
    if (self) {
        // 构建双向无限循环滚动视图的数据结构基础——双向循环链表
        _list = [HLWDoubleLinkedCircularList doubleLinkedCircularListWithArray:array];
    }
    return self;
}

#pragma mark - ---------- lazy load
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        
        // disable auto size
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        // set delegate
        _scrollView.delegate = self;
        
        // set content size
        _scrollView.contentSize = CGSizeMake(3 * self.viewWidth, self.viewHeight);
        
        // enable paging
        _scrollView.pagingEnabled = YES;
        
        // hide indicators
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;

    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        
        // disable auto size
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        
        _pageControl.numberOfPages = _list.count;
        _pageControl.currentPage = 0;
        
        // color
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];

        // space
        _pageControlSpace = 10;

    }
    return _pageControl;
}

-(UIImageView *)leftImageView
{
    if (!_leftImageView) {
        CGRect frame = CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        _leftImageView = [[UIImageView alloc] initWithFrame:frame];
    }
    return _leftImageView;
}

-(UIImageView *)middleImageView
{
    if (!_middleImageView) {
        CGRect frame = CGRectMake(self.viewWidth, 0, self.viewWidth, self.viewHeight);
        _middleImageView = [[UIImageView alloc] initWithFrame:frame];
    }
    return _middleImageView;
}

-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        CGRect frame = CGRectMake(2 * self.viewWidth, 0, self.viewWidth, self.viewHeight);
        _rightImageView = [[UIImageView alloc] initWithFrame:frame];
    }
    return _rightImageView;
}

-(CGFloat)viewWidth
{
    if (!_viewWidth) {
        _viewWidth = self.view.frame.size.width;
    }
    return _viewWidth;
}

-(CGFloat)viewHeight
{
    if (!_viewHeight) {
        _viewHeight = self.view.frame.size.height;
    }
    return _viewHeight;
}

- (void)setArray:(NSArray *)array
{
    if (_array != array) {
        _array = array;
        
        // 重新构建双向无限循环滚动视图的数据结构基础——双向循环链表
        _list = [HLWDoubleLinkedCircularList doubleLinkedCircularListWithArray:array];

        // set nodes
        [self initLeftMiddleRightNodes];
        
        // set page control pages
        _pageControl.numberOfPages = _list.count;
    }
}

#pragma mark - ---------- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /*!
     不能在这里构建界面，因为此时还知道View的frame
     */
}

- (void)show
{
    [self initLeftMiddleRightNodes];

    [self addAndLayoutScrollView];
    
    [self setContentViews];
    
    [self addAndLayoutPageControl];

}

- (void)addAndLayoutScrollView
{
    // add
    [self.view addSubview:self.scrollView];
    
    // layout
    // x
    NSString *hFormat = @"H:|-(0)-[_scrollView]-(0)-|";
    NSDictionary *hViews = NSDictionaryOfVariableBindings(_scrollView);
    NSArray *hConstraints = [NSLayoutConstraint
                            constraintsWithVisualFormat:hFormat
                            options:0
                            metrics:nil
                            views:hViews];
    [self.view addConstraints:hConstraints];
    
    // y
    NSString *vFormat = @"V:|-(0)-[_scrollView]-(0)-|";
    NSDictionary *vViews = NSDictionaryOfVariableBindings(_scrollView);
    NSArray *vConstraints = [NSLayoutConstraint
                             constraintsWithVisualFormat:vFormat
                             options:0
                             metrics:nil
                             views:vViews];
    [self.view addConstraints:vConstraints];
}

- (void)addAndLayoutPageControl
{
    // add
    [self.view addSubview:self.pageControl];
    [self.view bringSubviewToFront:self.pageControl];
    
    // layout
    // x
    
    NSLayoutAttribute layoutAttribute;
    CGFloat space = _pageControlSpace;
    if (PageControlPositionRight == _pageControlPosition) {
        layoutAttribute = NSLayoutAttributeRight;
    } else if (PageControlPositionMiddle == _pageControlPosition) {
        layoutAttribute = NSLayoutAttributeCenterX;
        space = 0;
    } else if (PageControlPositionLeft == _pageControlPosition) {
        layoutAttribute = NSLayoutAttributeLeft;
    }
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                  attribute:layoutAttribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.pageControl
                                                                  attribute:layoutAttribute
                                                                 multiplier:1
                                                                   constant:space];
    [self.view addConstraint:constraint];
    
    // y
    NSLayoutConstraint *vconstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.pageControl
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:0];
    [self.view addConstraint:vconstraint];
}

- (void)setContentViews
{
    [self removeContentViews];
    [self configContentViews];
    [self addContentViews];
    _scrollView.contentOffset = CGPointMake(self.viewWidth, 0);
    
    // set page control
    self.pageControl.currentPage = _middleNode.index;
    
    NSLog(@"current index: %lu", (unsigned long)_middleNode.index);
}

- (void)configContentViews
{
    self.leftImageView.image = [UIImage imageNamed:_leftNode.data];
    self.middleImageView.image = [UIImage imageNamed:_middleNode.data];
    self.rightImageView.image = [UIImage imageNamed:_rightNode.data];
    
}

- (void)addContentViews
{
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.middleImageView];
    [self.scrollView addSubview:self.rightImageView];
}

- (void)removeContentViews
{
    [self.leftImageView removeFromSuperview];
    [self.middleImageView removeFromSuperview];
    [self.rightImageView removeFromSuperview];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ---------- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
    CGPoint offset = scrollView.contentOffset;
    CGFloat pageIndex = offset.x / self.viewWidth;
    
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

// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%s", __func__);
    [_scrollView setContentOffset:CGPointMake(self.viewWidth, 0) animated:YES];
}

- (void)dealloc
{
    NSLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


@end
