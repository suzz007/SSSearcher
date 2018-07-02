//
//  UIImage+BoxBlur.h
//  LiveBlurView
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UIImage (BoxBlur)

/* blur the current image with a box blur algoritm */
- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur;

/**
 *  @brief  图片拉伸
 *  @return nil
 */
+ (UIImage *)imageStrechFrom:(NSString *)name;
@end
