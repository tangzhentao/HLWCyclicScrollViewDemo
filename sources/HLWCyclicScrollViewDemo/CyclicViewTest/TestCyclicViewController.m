//
//  TestCyclicViewController.m
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/9/12.
//  Copyright © 2016年 tang. All rights reserved.
//

#import "TestCyclicViewController.h"
#import "HLWCyclicScrollView.h"

@interface TestCyclicViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) HLWCyclicScrollView * cv;
@property (strong, nonatomic) NSArray * dataArray;

@end

@implementation TestCyclicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _cv = [HLWCyclicScrollView new];
    _cv.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_cv];
    
    [self layoutCV];
    
    _dataArray = @[@"IMG_0001.JPG", @"IMG_0002.JPG", @"IMG_0003.JPG", @"IMG_0004.JPG", @"IMG_0005.JPG", @"IMG_0006.JPG", @"IMG_0007.JPG"];
    
    _cv.contentArray = _dataArray;
    _cv.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
}

- (void)layoutCV
{
    NSString *hFormat = @"H:|-(0)-[_cv]-(0)-|";
    NSDictionary *hViews = NSDictionaryOfVariableBindings(_cv);
    NSArray *hConstraints = [NSLayoutConstraint
                            constraintsWithVisualFormat:hFormat
                            options:0
                            metrics:nil
                            views:hViews];
    [self.view addConstraints:hConstraints];
    
    NSString *vFormat = @"V:|-(60)-[_cv(100)]";
    NSArray *vConstraints = [NSLayoutConstraint
                             constraintsWithVisualFormat:vFormat
                             options:0
                             metrics:nil
                             views:hViews];
    [self.view addConstraints:vConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ---------- HLWCyclicScrollViewDelegate
-(NSInteger)numberOfPagesInCyclicScrollView:(HLWCyclicScrollView *)cyclicScrollView
{
    return self.dataArray.count;
}

-(id)cyclicScrollView:(HLWCyclicScrollView *)cyclicScrollView contentOfPageAtIndex:(NSUInteger)index
{
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
