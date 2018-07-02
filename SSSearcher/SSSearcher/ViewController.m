//
//  ViewController.m
//  SSSearcher
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "NSString+chineseTransform.h"
#import "DXFreContCell.h"
#import "DXSearchPopView.h"
#import "DXSearchView.h"
#import "SearchCoreManager.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
#define COLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
static CGFloat viewOffset = 64;
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) DXSearchView * searchBar;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView * navigation_View;
@property (nonatomic,strong) DXSearchPopView * searchPopView;
@property (nonatomic,strong) NSMutableDictionary * dataDict;//搜索数据源
@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic,strong) NSMutableArray * searchNameResultArry;
@end

@implementation ViewController

//改变statusBar的颜色
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle  = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle  = UIStatusBarStyleLightContent;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setNavigationViewTo_dis];
    [self setSearchViewTo_dis];
    [self setTableViewTo_dis];
    [self setSearchPopViewTo_dis];
    [self.tableView reloadData];
}
- (void)setNavigationViewTo_dis{
    
    self.navigation_View = ({
        UIView * view = UIView.new;
        view.backgroundColor = COLOR_HEX(0x467dff);
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(self.view);
            make.height.mas_equalTo(IS_IPHONE_X ? 88 : 64);
        }];
        

        UILabel * titleLbl = UILabel.new;
        titleLbl.font = [UIFont systemFontOfSize:18];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.text = @"常用联系人";
        [view addSubview:titleLbl];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
        }];
        
        
        view;
    });
}
- (void)setSearchPopViewTo_dis{
    self.searchPopView = ({
        DXSearchPopView * popView = [[DXSearchPopView alloc]initWithAttributeBlock:^(DXSearchPopView *popView) {
            popView.animationTime = 0.25;
        }];
        [self.view addSubview:popView];
        [popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left);
            make.width.mas_equalTo(self.view.mas_width);
            make.height.mas_equalTo(self.view.bounds.size.height - (IS_IPHONE_X ? 88 : 64));
        }];
        popView;
    });
}

- (void)setSearchViewTo_dis{
    DXSearchView * bar = [[DXSearchView alloc]init];
    [self.view addSubview:bar];
    self.searchBar = bar;
    __weak typeof(self)weakSelf = self;
    bar.editingBlock = ^{
        
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset);
            weakSelf.searchBar.transform = CGAffineTransformMakeTranslation(0, -viewOffset + 20);
            weakSelf.searchBar.backgroundColor = UIColor.whiteColor;
            weakSelf.searchBar.showCancelBtn = YES;
            weakSelf.navigation_View.backgroundColor = UIColor.whiteColor;
        }];
        [weakSelf.searchPopView showThePopViewWithArray:@[]];
    };
    bar.endEditingBlock = ^{
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.navigationController.navigationBar.transform = CGAffineTransformIdentity;
            weakSelf.searchBar.transform = CGAffineTransformIdentity;
            weakSelf.searchBar.backgroundColor = UIColor.clearColor;
            weakSelf.searchBar.showCancelBtn = NO;
            weakSelf.navigation_View.backgroundColor = COLOR_HEX(0x467dff);
        }];
        weakSelf.searchPopView.dataSource = @[];
        [weakSelf.searchPopView dismissThePopView];
        weakSelf.searchPopView.dataSource = @[];
    };
    bar.searchResultBlock = ^(NSString * searchRusult){

};
    bar.place_holderText = @"搜索";
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.navigation_View.mas_bottom);
    }];
    
    bar.editTextChanged = ^(NSString *text) {
        [[SearchCoreManager share] Search:text searchArray:nil nameMatch:weakSelf.searchNameResultArry phoneMatch:nil];
        NSNumber * localID;
        NSMutableString *matchString = [NSMutableString string];//为了在库中找到匹配的号码或者是拼音 有那个显示那个
        NSMutableArray * tmpArry = NSMutableArray.new;
        NSMutableArray *matchPos = [NSMutableArray array];
        for (int i = 0; i < weakSelf.searchNameResultArry.count; i ++) {
            localID = [weakSelf.searchNameResultArry objectAtIndex:i];
            
            if ([text length]) {
                [[SearchCoreManager share] GetPinYin:localID pinYin:matchString matchPos:matchPos];
                DXFreContModel * model = [weakSelf.dataDict objectForKey:localID];
                [tmpArry addObject:model];
                NSMutableAttributedString * attributedString = [NSString lightStringWithSearchResultName:model.name matchArray:matchPos inputString:text lightedColor:COLOR_HEX(0x467dff)];
                model.attributedString = attributedString;
            }
        }
        weakSelf.searchPopView.dataSource = tmpArry.mutableCopy;
    };
    
}
- (void)setTableViewTo_dis{
    UITableView * tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.rowHeight = 55;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.searchBar.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    tableView.backgroundColor = COLOR_HEX(0xf1f1f1);
    tableView.tableFooterView = UIView.new;
}

- (void)initData{
    NSMutableArray * tmpArray = NSMutableArray.new;
    for (int i = 0; i < 3; i ++) {
        DXFreContModel * model = [[DXFreContModel alloc]initWithName:[NSString stringWithFormat:@"%@%d",@"苏帅",i] mobileNum:@"10089" image:@"ss_image"];
        [tmpArray addObject:model];
    }
    DXFreContModel * model = [[DXFreContModel alloc]initWithName:@"StevenJobs" mobileNum:@"10086" image:@"ss_jobs"];
    [tmpArray addObject:model];
    DXFreContModel * model2 = [[DXFreContModel alloc]initWithName:@"北京" mobileNum:@"10086" image:nil];
    [tmpArray addObject:model2];
    DXFreContModel * model3 = [[DXFreContModel alloc]initWithName:@"大狸子" mobileNum:@"10086" image:@"ss_dalizi"];
    [tmpArray addObject:model3];
    DXFreContModel * model4 = [[DXFreContModel alloc]initWithName:@"绯红女巫" mobileNum:@"10086" image:@"ss_witch"];
    [tmpArray addObject:model4];
    DXFreContModel * model5 = [[DXFreContModel alloc]initWithName:@"黑寡妇" mobileNum:@"10086" image:@"ss_blackwidow"];
    [tmpArray addObject:model5];
    
    for (int i = 10; i < 19; i ++) {
        DXFreContModel * model = [[DXFreContModel alloc]initWithName:[NSString stringWithFormat:@"%@%d",@"测试",i] mobileNum:@"10089" image:nil];
        [tmpArray addObject:model];
    }
    
    _dataSource = tmpArray.mutableCopy;
    
    for (int i = 0; i<self.dataSource.count; i++) {
        DXFreContModel * model = self.dataSource[i];
        [[SearchCoreManager share]AddContact:@(i) name:model.name phone:nil];
        [self.dataDict setObject:model forKey:@(i)];
    }
}

#pragma mark - UITableViewDataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource == nil ? 10 : self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DXFreContCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[DXFreContCell alloc]initWithDXFrecontCellStyle:DXFreContCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = (DXFreContModel *)self.dataSource[indexPath.row];
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = UIView.new;
    view.backgroundColor = UIColor.whiteColor;
    UILabel * lbl = UILabel.new;
    lbl.font = [UIFont systemFontOfSize:15];
    lbl.textColor = [UIColor colorWithRed:(53/255.0) green:(53/255.0) blue:(53/255.0) alpha:1.0];
    lbl.text = @"常用联系人";
    [view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(15);
    }];
    return view;
}

- (NSMutableDictionary *)dataDict{
    
    if (!_dataDict) {
        _dataDict = NSMutableDictionary.new;
    }
    return _dataDict;
}

- (NSMutableArray *)searchNameResultArry{
    
    if (!_searchNameResultArry) {
        _searchNameResultArry = [NSMutableArray array];
    }
    return _searchNameResultArry;
}


@end
