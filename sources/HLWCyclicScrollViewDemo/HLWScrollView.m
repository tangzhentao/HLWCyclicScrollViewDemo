//
//  HLWScrollView.m
//  HLWCyclicScrollViewDemo
//
//  Created by tang on 16/9/6.
//  Copyright © 2016年 tang. All rights reserved.
//

#import "HLWScrollView.h"

@implementation HLWScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"scroll view frame: %@", NSStringFromCGRect(frame));
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"scroll view frame: %@", NSStringFromCGRect(self.frame));
    }
    return self;
}

- (void)layoutSubviews
{
    NSLog(@"[%@ %@]: frame: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), NSStringFromCGRect(self.frame));
}

@end
