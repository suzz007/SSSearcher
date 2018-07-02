//
//  DXFreContModel.m
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import "DXFreContModel.h"

@implementation DXFreContModel

- (instancetype)initWithName:(NSString *)name mobileNum:(NSString *)mobileNum image:(NSString *)image{
    if (self == [super init]) {
        self = [super init];
        self.name = name;
        self.mobile = mobileNum;
        self.image = image;
    }
    return self;
}

@end
