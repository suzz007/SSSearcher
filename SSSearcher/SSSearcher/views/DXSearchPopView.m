//
//  DXSearchPopView.m
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import "DXSearchPopView.h"
#import "Masonry.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

@interface DXSearchPopView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DXSearchPopView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = UIColor.whiteColor;
    self.tableView = ({
        UITableView * tbView = UITableView.new;
        tbView.backgroundColor = UIColor.whiteColor;
        tbView.dataSource = self;
        tbView.delegate = self;
        tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [self addSubview:tbView];
        [tbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        tbView.tableFooterView = UIView.new;
        tbView;
    });
}
- (instancetype)initWithAttributeBlock:(void (^)(DXSearchPopView *))attributeBlock{
    if (self = [super init]) {
//        attributeBlock();
        if (attributeBlock) {
            attributeBlock(self);
        }
        [self setUpUI];
    }
    
    return self;
}

- (void)showThePopViewWithArray:(NSMutableArray *)array{
    self.dataSource = array;
//    [self.tableView reloadData];
    //1.执行动画
    [UIView animateWithDuration:self.animationTime animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -(SCREEN_HEIGHT - (IS_IPHONE_X ? 88 : 64)));
        
    }];
    
}

- (void)dismissThePopView{
    [UIView animateWithDuration:self.animationTime animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //        [self removeFromSuperview];
        self.dataSource = @[];
    }];
    
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource == nil ? 10 : self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";

    if (self.dataSource != nil) {
        
        DXFreContCell * cell = [tableView dequeueReusableCellWithIdentifier:@"otherCellId"];
        if (!cell) {
            if (self.cellStyle == DXFreContCellStyleDefault) {
                
                cell = [[DXFreContCell alloc]initWithDXFrecontCellStyle:DXFreContCellStyleDefault reuseIdentifier:cellID];
            }else{
                cell = [[DXFreContCell alloc]initWithDXFrecontCellStyle:DXFreContCellStyleDis_correct reuseIdentifier:cellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        DXFreContModel * model = self.dataSource[indexPath.row];
        cell.model = model;
        [cell setCellAttributeString:model.attributedString];
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataSource == nil) {
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DXFreContModel * model = self.dataSource[indexPath.row];
    if (self.selectPopElement) {
        self.selectPopElement(model);
    }
    
}
- (void)reloadTableView{
    [self.tableView reloadData];    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
