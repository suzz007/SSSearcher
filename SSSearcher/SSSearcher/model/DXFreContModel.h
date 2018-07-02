//
//  DXFreContModel.h
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 装载常用联系人的模型
 */
@interface DXFreContModel : NSObject
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * mobile; 
@property (nonatomic,copy) NSString * bizOrgName;
@property (nonatomic,assign) NSInteger tag;
@property (nonatomic,copy) NSString * relatedId;
@property (nonatomic,copy) NSString * identityNo;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,assign) int contactFlag;
//mobile
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,copy) NSMutableAttributedString * attributedString;

- (instancetype)initWithName:(NSString *)name mobileNum:(NSString *)mobileNum image:(NSString *)image;

@end
