//
//  ViewController.m
//  HJButtonAddExtension
//
//  Created by 黄静静 on 2017/7/16.
//  Copyright © 2017年 Jing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@property (nonatomic, strong) NSView *testView;

@end

@implementation ViewController
{
    NSView *_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _view = [self view];
    
//#pragma mark - M
//    [_testView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(0);
//    }];
    // Do any additional setup after loading the view.
}

#pragma mark - Get
- (NSView *)testView{
    if (_testView == nil) {
        _testView = [[NSView alloc] init];
    }
    return _testView;
}

- (NSView *)view{
    if (_view == nil) {
        _view = [[NSView alloc] init];
    }
    return _view;
}

@end
