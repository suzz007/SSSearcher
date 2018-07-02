//
//  UIButton+Block.h
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Block)
@property(nonatomic,copy)void(^actionBlock)(UIButton *);
-(void)addTargetActionBlock:(void(^)(UIButton *btn))block;
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;
@end
