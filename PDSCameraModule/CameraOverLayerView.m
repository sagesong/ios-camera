//
//  CameraOverLayerView.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "CameraOverLayerView.h"
#import "Masonry.h"
@implementation CameraOverLayerView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        CameraTopView *top = [[CameraTopView alloc] init];
        self.topView = top;
        [self addSubview:top];
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.right.equalTo(self);
            make.height.equalTo(@64);
        }];
        
        CameraBottomView *bottom = [[CameraBottomView alloc] init];
        self.bottomView = bottom;
        [self addSubview:bottom];
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.leading.right.equalTo(self);
            make.height.equalTo(@64);
        }];
    }
    return self;
}

@end
