//
//  DXFreContCell.m
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import "DXFreContCell.h"
#import "Masonry.h"
#define COLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

@interface DXFreContCell()
@property (nonatomic,strong) UIImageView * icon;
@end

@implementation DXFreContCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellAttributeString:(NSMutableAttributedString *)attributeString{
    if (attributeString == nil) {
        return;
    }
    _nameLbl.attributedText = attributeString;
}

- (instancetype)initWithDXFrecontCellStyle:(DXFreContCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.cellStyle = style;
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{
    _nameComponent = UILabel.new;
    _nameComponent.backgroundColor = COLOR_HEX(0x467fff);
    _nameComponent.textColor = UIColor.whiteColor;
    _nameComponent.textAlignment = NSTextAlignmentCenter;
    UIFont * font = [UIFont systemFontOfSize:11];
    [_nameComponent setFont:font];
//    _nameComponent.frame = CGRectMake(15, 5, 30, 30);
    [self addSubview:_nameComponent];

    [_nameComponent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.and.width.mas_equalTo(@35);
    }];
    _nameComponent.layer.borderColor = UIColor.whiteColor.CGColor;
    _nameComponent.layer.cornerRadius = 35/2;
    _nameComponent.layer.masksToBounds=YES;

    
    _nameLbl = UILabel.new;
    [_nameLbl setFont:[UIFont systemFontOfSize:14]];
    _nameLbl.textColor = COLOR_HEX(0x353535);
    [self addSubview:_nameLbl];
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self->_nameComponent.mas_right).offset(10);
    
    if (self.cellStyle == DXFreContCellStyleDefault) {
        self->_callPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //    _callPhoneBtn.imageView.image = [UIImage imageNamed:@"txl10"];
        [self->_callPhoneBtn setImage:[UIImage imageNamed:@"txl10"] forState:UIControlStateNormal];
        //[_callPhoneBtn setImage:[UIImage imageNamed:@"txl11"] forState:UIControlStateDisabled];
        [self->_callPhoneBtn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self->_callPhoneBtn];
        self.callPhoneBtn.enabled = self->_model.mobile == nil ? NO : YES;
        [self->_callPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-10);
        }];
    }else{
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"check-unselect"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"jp05"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"contact_unselect_01"] forState:UIControlStateDisabled];
        self.correctBtn = btn;
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(self.mas_right).offset(- 10);
        }];
    }
    }];
    _icon = UIImageView.new;
    _icon.hidden = YES;
    [self addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.and.width.mas_equalTo(@35);
    }];
    _icon.layer.borderColor = UIColor.whiteColor.CGColor;
    _icon.contentMode = UIViewContentModeScaleAspectFill;
    _icon.layer.cornerRadius = 35/2;
    _icon.layer.masksToBounds=YES;
}

- (void)callPhone:(UIButton *)btn{
    
//    NSLog(@"%s",__func__);
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"确定要拨打电话吗" message:_model.mobile preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * actionTrue = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        NSMutableString  *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",_model.mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alert addAction:actionTrue];
    [alert addAction:cancelAction];
    [self viewController] == nil ? : [[self viewController]presentViewController:alert animated:NO completion:nil];


}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/**
 常用联系人转载数据的方法

 @param model 常用联系人模型
 */
- (void)setModel:(DXFreContModel *)model{
    _model = model;
    NSString * tStr = model.name;
    self.nameLbl.text = tStr;

    if ([model.name isEqualToString:@""] || model.name == nil) {
        self.nameLbl.text = @"未命名联系人";
    }
    self.icon.hidden = YES;
    if (model.name.length >= 2) {
        self.nameComponent.text = [tStr substringFromIndex:model.name.length - 2];
    }else{
        self.nameComponent.text = model.name;
    }
    
    self.callPhoneBtn.enabled = [model.mobile isEqualToString:@""] || model.mobile == nil ? NO : YES;
    if (model.image != nil && ![model.image isKindOfClass:[NSNull class]]) {
        _icon.hidden = NO;
        _icon.image = [UIImage imageNamed:model.image];
    }
    
}

@end
