//
//  CameraTopView.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "CameraTopView.h"
#import "Masonry.h"
@interface CameraTopView ()


@property (nonatomic, weak) UIButton *backBtn;
@property (nonatomic, weak) UIButton *flashBtn;
@property (nonatomic, weak) UIButton *microBtn;
@property (nonatomic, weak) UIButton *switchBtn;

@property (nonatomic, assign) BOOL enableMicro;
@property (nonatomic, assign) BOOL enableFlash;

@end

@implementation CameraTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupConstrains];
    }
    return self;
}

- (void)setupUI
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"camera_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"camera_back_highlight"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _backBtn = backBtn;
    
    UIButton *microBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:microBtn];
    [microBtn setImage:[UIImage imageNamed:@"camera_micro"] forState:UIControlStateNormal];
    [microBtn setImage:[UIImage imageNamed:@"camera_micro_highlight"] forState:UIControlStateHighlighted];
    //    [microBtn setImage:[UIImage imageNamed:@"Camera_no_micro"] forState:UIControlStateSelected];
    [microBtn addTarget:self action:@selector(microBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _microBtn = microBtn;
    
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:flashBtn];
    [flashBtn setImage:[UIImage imageNamed:@"Camera_no_flash_highlight"] forState:UIControlStateHighlighted];
    [flashBtn setImage:[UIImage imageNamed:@"Camera_no_flash"] forState:UIControlStateNormal];
    //    [flashBtn setImage:[UIImage imageNamed:@"Camera_no_flash"] forState:UIControlStateSelected];
    [flashBtn addTarget:self action:@selector(flashBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    _flashBtn = flashBtn;
    
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:switchBtn];
    [switchBtn setImage:[UIImage imageNamed:@"camera_switch"] forState:UIControlStateNormal];
    [switchBtn setImage:[UIImage imageNamed:@"camera_switch_highlight"] forState:UIControlStateHighlighted];
    [switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _switchBtn = switchBtn;
}

- (void)setupConstrains
{
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.right.equalTo(self.microBtn.mas_leading);
        make.height.equalTo(self);
        make.width.equalTo(self.microBtn);
        
    }];
    
    [self.microBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backBtn.mas_right);
        make.right.equalTo(self.flashBtn.mas_leading);
        make.height.equalTo(self);
        make.width.equalTo(self.flashBtn);
    }];
    
    [self.flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.microBtn.mas_right);
        make.right.equalTo(self.switchBtn.mas_leading);
        make.height.equalTo(self);
        make.width.equalTo(self.switchBtn);
    }];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.flashBtn.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(self);
//        make.width.equalTo(self);
    }];
}

#pragma Event Response
- (void)backBtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(backBtnClicked)]) {
        [self.delegate backBtnClicked];
    }
}

- (void)microBtnClick:(UIButton *)btn
{
    NSLog(@"micro clicked");
    self.enableMicro = !self.enableMicro;
    if (!self.enableMicro) {
        [btn setImage:[UIImage imageNamed:@"Camera_no_micro"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Camera_no_micro_highlight"] forState:UIControlStateHighlighted];
    } else {
        [btn setImage:[UIImage imageNamed:@"camera_micro"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"camera_micro_highlight"] forState:UIControlStateHighlighted];
    }
    if ([self.delegate respondsToSelector:@selector(microBtnClicked:)]) {
        [self.delegate microBtnClicked:self.enableMicro];
    }
}

- (void)flashBtnclick:(UIButton *)btn
{
    self.enableFlash = !self.enableFlash;
    if (!self.enableFlash) {
        [btn setImage:[UIImage imageNamed:@"Camera_no_flash_highlight"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"Camera_no_flash"] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:@"camera_flash"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"camera_flash_highlight"] forState:UIControlStateHighlighted];
    }
    if ([self.delegate respondsToSelector:@selector(flashBtnClicked:)]) {
        [self.delegate flashBtnClicked:self.enableFlash];
    }
}

- (void)switchBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if ([self.delegate respondsToSelector:@selector(switchBtnClicked)]) {
        [self.delegate switchBtnClicked];
    }
    self.flashBtn.hidden = !self.flashBtn.hidden;
}
@end
