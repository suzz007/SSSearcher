//
//  DXSearchPopView.h
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXFreContCell.h"
@interface DXSearchPopView : UIView
@property (nonatomic,assign) CGFloat animationTime;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic,assign) DXFreContCellStyle cellStyle;
@property (nonatomic,copy) void(^selectPopElement)(DXFreContModel * model);

/**展示tableView
 @param array dataSource */
- (void)showThePopViewWithArray:(NSMutableArray *)array;
/** *  移除popView */
- (void)dismissThePopView;

- (instancetype)initWithAttributeBlock:(void(^)(DXSearchPopView * popView))attributeBlock;

- (void)reloadTableView;

@end
