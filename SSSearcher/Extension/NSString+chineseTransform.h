//
//  NSString+chineseTransform.h
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (chineseTransform)

/**
 汉字转pinyin

 @param chineseString 中文汉字
 @return 拼音字母
 */
+ (NSString *)chinese_Pinyin:(NSString *)chineseString;


/**
 匹配汉字高亮效果的attributeString
 */
+ (NSMutableAttributedString *)lightStringWithSearchResultName:(NSString *)searchResultName matchArray:(NSArray *)matchArray inputString:(NSString *)inputString lightedColor:(UIColor *)lightedColor;
@end
