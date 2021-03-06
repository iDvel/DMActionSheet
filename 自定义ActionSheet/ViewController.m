//
//  ViewController.m
//  自定义ActionSheet
//
//  Created by Dvel on 15/12/7.
//  Copyright © 2015年 Dvel. All rights reserved.
//

#import "ViewController.h"
#import "DMCustomActionSheet.h"

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_BOUNDS.size.width / 2 - 50,
																  SCREEN_BOUNDS.size.height / 3 + 50,
																  100, 100)];
	[button setTitle:@"我是一个按钮" forState:UIControlStateNormal];
	button.backgroundColor = [UIColor purpleColor];
	[self.view addSubview:button];
	[button addTarget:self action:@selector(showCustomActionSheet) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showCustomActionSheet
{
	UIView *view = [[UIView alloc] init];
	view.backgroundColor = [UIColor blueColor];
	
	[self.view addSubview:[DMCustomActionSheet actionSheetWithView:view height:200]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	NSLog(@"你点到我了");
}

@end
