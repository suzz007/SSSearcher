//
//  DXSearchView.h
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 自定义searchBar 只设置加载在viewController.view上
 */
@interface DXSearchView : UIView
@property (nonatomic,copy) NSString * place_holderText;
@property (nonatomic,copy) void(^editingBlock)(void);
@property (nonatomic,copy) void(^editTextChanged)(NSString * text);

@property (nonatomic,copy) void(^endEditingBlock)(void);
@property (nonatomic,copy) void(^searchResultBlock)(NSString * searchRusult);
@property (nonatomic,assign) BOOL showCancelBtn;
//- (instancetype)initWithEditingBlock:(void(^)(DXSearchView * searchView))editingBlock;
@end
