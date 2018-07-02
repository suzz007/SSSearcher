//
//  UITextField (RAC)
//  SSSearcher
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (RAC)
@property(nonatomic,copy)void(^editTextHandler)(NSString *text);
@end
