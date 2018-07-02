//
//  DXFreContCell.h
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXFreContModel.h"
typedef NS_ENUM (NSInteger,DXFreContCellStyle) {
    /// 默认展示拨打电话
    DXFreContCellStyleDefault,
    /// 展示勾选
    DXFreContCellStyleDis_correct,

} ;

@interface DXFreContCell : UITableViewCell
@property(nonatomic,copy)void(^callPhoneBlock)(NSString *phoneNum);
@property (nonatomic,strong) UILabel *nameComponent;
@property (nonatomic,strong) UILabel *nameLbl;
@property (nonatomic,strong) UIButton * callPhoneBtn;
@property (nonatomic,strong) UIButton * correctBtn;
@property (nonatomic,strong) DXFreContModel * model;
@property (nonatomic,assign) DXFreContCellStyle cellStyle;

- (instancetype)initWithDXFrecontCellStyle:(DXFreContCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setCellAttributeString:(NSMutableAttributedString *)attributeString;
@end
