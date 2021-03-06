//
//  DMCustomActionSheet.m
//  自定义ActionSheet
//
//  Created by Dvel on 15/12/7.
//  Copyright © 2015年 Dvel. All rights reserved.
//

#import "DMCustomActionSheet.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define MARGIN 8
#define CANCEL_BUTTON_WIDTH (SCREEN_WIDTH - 16)
#define CANCEL_BUTTON_HEIGHT 55

@interface DMCustomActionSheet ()
/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancelButton;
/** 自定义的ActionSheetView */
@property (nonatomic, strong) UIView *actionSheetView;
@end

@implementation DMCustomActionSheet

+ (instancetype)actionSheetWithView:(UIView *)view height:(CGFloat)height
{
	return [[DMCustomActionSheet alloc] initWithView:view height:height];
}

- (instancetype)initWithView:(UIView *)view height:(CGFloat)height
{
	self = [super init];
	if (self) {
		// 1.设置大背景
		self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWhenTap)];
		[self addGestureRecognizer:tapGesture];
		
		// 2.设置传入的view：
		self.actionSheetView = ({
			view.frame = CGRectMake(MARGIN, SCREEN_HEIGHT, CANCEL_BUTTON_WIDTH, height);
			view.layer.cornerRadius = 10;
			UITapGestureRecognizer *noTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noTap)];
			[view addGestureRecognizer:noTap];
			view;
		});
		
		// 3.设置动画
		[self addSubview:self.cancelButton];
		[self addSubview:self.actionSheetView];
		[UIView animateWithDuration:0.25 animations:^{
			self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
			// 取消按钮动画：从屏幕下面提上来
			self.cancelButton.frame = CGRectMake(MARGIN,
												 SCREEN_HEIGHT - CANCEL_BUTTON_HEIGHT - MARGIN,
												 CANCEL_BUTTON_WIDTH,
												 CANCEL_BUTTON_HEIGHT);
			// actionSheetView动画：从屏幕下面提上来
			self.actionSheetView.frame = CGRectMake(MARGIN,
													CGRectGetMinY(self.cancelButton.frame) - 8 - height,
													CANCEL_BUTTON_WIDTH,
													height);
		}];
	}
	return self;
}

/** 取消按钮 */
- (UIButton *)cancelButton
{
	if (_cancelButton == nil) {
		_cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		// 默认高度：actionSheetView在屏幕下面，取消按钮在actionSheetView下面+8个长度。
		_cancelButton.frame = CGRectMake(MARGIN,
										 CGRectGetMaxY(self.actionSheetView.frame) + MARGIN,
										 CANCEL_BUTTON_WIDTH,
										 CANCEL_BUTTON_HEIGHT);
		_cancelButton.layer.cornerRadius = 10;
		
		[_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
		_cancelButton.backgroundColor = [UIColor whiteColor];
		[_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_cancelButton addTarget:self action:@selector(hideWhenTap) forControlEvents:UIControlEventTouchUpInside];
	}
	return _cancelButton;
}

#pragma mark 私有方法
/** 消失动画 */
- (void)hideWhenTap
{
	[UIView animateWithDuration:0.25 animations:^{
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
		// 100 ： 只要大于取消按钮的高度即可。
		[self.cancelButton setFrame:CGRectMake(MARGIN, SCREEN_HEIGHT + 100, CANCEL_BUTTON_WIDTH, CANCEL_BUTTON_HEIGHT)];
		[self.actionSheetView setFrame:CGRectMake(MARGIN, SCREEN_HEIGHT + CANCEL_BUTTON_HEIGHT + 100, CANCEL_BUTTON_WIDTH, CANCEL_BUTTON_HEIGHT)];
	} completion:^(BOOL finished) {
		if (finished) {
			[self removeFromSuperview];
		}
	}];
}

/** 啥都不写，为了给ActionSheetView取消tap手势 */
- (void)noTap {}

/** 啥也不写，屏蔽掉父视图的touchesBegan */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}

@end
