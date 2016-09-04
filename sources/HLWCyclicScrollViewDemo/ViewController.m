//
//  ViewController.m
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/8/31.
//  Copyright © 2016年 tang. All rights reserved.
//

#import "ViewController.h"
#import "HLWCyclicScrollView.h"
#import "HLWCyclicViewController.h"

@interface ViewController ()

@property (strong, nonatomic) HLWCyclicViewController * cyclicViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _cyclicViewController = [HLWCyclicViewController cyclicViewControllerWithArray:@[@"1.png"]];
    UIView *view = _cyclicViewController.view;
    view.frame = CGRectMake(20, 60, 300, 200);
    view.backgroundColor = [UIColor whiteColor];
    
    [_cyclicViewController show];

    
    [self.view addSubview:view];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    [self.view.subviews.firstObject removeFromSuperview];

    _cyclicViewController.array = @[@"2.png", @"3.png", @"4.png", @"5.png"];
    [_cyclicViewController show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
