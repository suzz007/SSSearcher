//
//  DXSearchView.m
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import "DXSearchView.h"
#import "UIImage+BoxBlur.h"
#import "Masonry.h"
#import "DXFreContModel.h"
#import "UITextField+RAC.h"
@interface DXSearchView ()<UITextFieldDelegate>
#define COLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

@property (nonatomic,strong) UIView * contentView;

/** 单独搜索框 */
@property (nonatomic,strong) UIImageView * back_view;

/** 搜索图标 */
@property (nonatomic,strong) UIImageView * search_icon;

/** 搜索功能按钮 */
@property (nonatomic,strong) UITextField * place_holder;
/** 取消按钮 */
@property (nonatomic,strong) UIButton * cacelBtn;
@property (nonatomic,strong) NSArray * dataSource;
@end

@implementation DXSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI{
    self.contentView = ({
        UIView * view = UIView.new;
        view.backgroundColor = UIColor.clearColor;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        view;
    });
    
    self.back_view = ({
        UIImageView * back_view = UIImageView.new;
        back_view = UIImageView.new;
        back_view.backgroundColor = [UIColor clearColor];
        back_view.userInteractionEnabled = YES;
        [self addSubview:back_view];
        back_view.image = [UIImage imageStrechFrom:@"s_map_searcher"];
        [back_view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(- 15);
        }];
        back_view;
    });
    
    self.search_icon = ({
        UIImageView * search_icon = UIImageView.new;

        search_icon.backgroundColor = [UIColor clearColor];
        [_back_view addSubview:search_icon];
        search_icon.image = [UIImage imageNamed:@"txl113"];
        [search_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25 /2);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(20);
        }];
        search_icon;
    });
    
    self.place_holder = ({
        UITextField * place_holder = [UITextField new];
        place_holder.tag = 102;
        place_holder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        place_holder.font = [UIFont systemFontOfSize:14];
        [place_holder setTextColor:UIColor.lightGrayColor];
        place_holder.clearButtonMode = UITextFieldViewModeWhileEditing;
        place_holder.userInteractionEnabled = YES;
        place_holder.delegate = self;
        place_holder.returnKeyType = UIReturnKeySearch;
        [self.back_view addSubview:place_holder];
        [place_holder addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        place_holder.editTextHandler = self.editTextChanged;
        [place_holder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.mas_equalTo(self.search_icon);
            make.left.mas_equalTo(self.search_icon.mas_right).offset(20/2.0);
            make.right.mas_equalTo(self.back_view.mas_right);
        }];
        place_holder;
    });
    
    self.cacelBtn = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(self.mas_right).offset(-15);
        }];
        [button setTitleColor:COLOR_HEX(0x467dff) forState:UIControlStateNormal];
        [button setTitleColor:COLOR_HEX(0x467dff) forState:UIControlStateHighlighted];
        button.userInteractionEnabled = YES;
        button.hidden = YES;
        button;
    });
}

- (void)setShowCancelBtn:(BOOL)showCancelBtn{
    _showCancelBtn = showCancelBtn;
    if (showCancelBtn) {
        [self.back_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- 65);
        }];
        self.cacelBtn.hidden = NO;
    }else{
        [self.back_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(- 15);
        }];
        self.cacelBtn.hidden = YES;
    }
    
}

- (void)setPlace_holderText:(NSString *)place_holderText{
    
    _place_holderText = place_holderText;
    self.place_holder.placeholder = place_holderText;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    self.searchResultBlock(textField.text);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    textField.placeholder = nil;
    if (self.editingBlock) {
        self.editingBlock();
    }
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if (self.editTextChanged) {
        self.editTextChanged(theTextField.text);
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    
}

- (void)cancelBtnClick:(UIButton *)button{
    NSLog(@"%s",__func__);
    [self.place_holder endEditing:YES];
    self.place_holder.text = nil;
    self.place_holder.placeholder = self.place_holderText;
    self.dataSource = nil;
    
    if (self.endEditingBlock) {
        self.endEditingBlock();
    }
}
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    BOOL flag = NO;
//    for (UIView * view in self.subviews) {
//        if (CGRectContainsPoint(view.frame, point)) {
//            flag = YES;
//            break;
//        }
//    }
//    return flag;
//}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    CGPoint btnP = [self convertPoint:point toView:self.cacelBtn];
//    CGPoint textFieldP = [self convertPoint:point toView:self.place_holder];
//    if ([self.cacelBtn pointInside:btnP withEvent:event]) {
//
//        return self.cacelBtn;
//    }else if([self.place_holder pointInside:textFieldP withEvent:event]){
//        return self.place_holder;
//    }
//    else{
//
//        return [super hitTest:point withEvent:event];
//    }
//
//
//}

@end
