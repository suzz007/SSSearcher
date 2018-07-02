//
//  UITextField (RAC)
//  SSSearcher
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import "UITextField+RAC.h"
#import <objc/runtime.h>

@implementation UITextField (RAC)

- (void)setEditTextHandler:(void (^)(NSString *))editTextHandler{
    objc_setAssociatedObject(self, @selector(editTextHandler), editTextHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(tapResponse:) forControlEvents:UIControlEventEditingChanged];
}

-(void (^)(NSString *))editTextHandler
{
    return objc_getAssociatedObject(self, @selector(editTextHandler));
}

-(void)tapResponse:(NSString *)text{
    if (self.editTextHandler) {
        self.editTextHandler(self.text);
    }
}

@end
