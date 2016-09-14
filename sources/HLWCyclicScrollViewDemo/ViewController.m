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
#import "HLWScrollView.h"
#import "TestCyclicViewController.h"

@interface ViewController ()

@property (strong, nonatomic) HLWCyclicViewController * cyclicViewController;
@property (weak, nonatomic) IBOutlet HLWCyclicScrollView *cyclicScrollView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
//    [self addHLWScrollView];
    
//
}

- (void)addHLWScrollView
{
    HLWScrollView *view = [[HLWScrollView alloc] initWithFrame:CGRectMake(40, 240, 300, 200)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    contentView.backgroundColor = [UIColor redColor];
    view.contentSize = CGSizeMake(400, 400);
    [view addSubview:contentView];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestCyclicViewController *tcvc = [TestCyclicViewController new];
    [self presentViewController:tcvc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
