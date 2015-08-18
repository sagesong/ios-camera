//
//  CameraBottomView.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "CameraBottomView.h"
#import "Masonry.h"
@interface CameraBottomView ()

@property (nonatomic, weak) UIButton *cloudBtn;
@property (nonatomic, weak) UIButton *photoBtn;
@property (nonatomic, weak) UIButton *pauseBtn;
@property (nonatomic, weak) UIButton *recBtn;

@property (nonatomic, assign) BOOL recording;
@property (nonatomic, assign) CGRect origialPhotoBtnFrame;
@end

@implementation CameraBottomView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
        [self setupConstrains];
    }
    
    return self;
}

- (void)setupUI
{
    UIButton *recBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:recBtn];
    recBtn.exclusiveTouch = YES;
    _recBtn = recBtn;
    [recBtn setImage:[UIImage imageNamed:@"Bottom_Start"] forState:UIControlStateNormal];
    [recBtn setImage:[UIImage imageNamed:@"Bottom_Start_highlight"] forState:UIControlStateHighlighted];
    [recBtn addTarget:self action:@selector(recBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *cloudBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cloudBtn];
    cloudBtn.exclusiveTouch = YES;
    _cloudBtn = cloudBtn;
    [cloudBtn setImage:[UIImage imageNamed:@"Bottom_Cloud"] forState:UIControlStateNormal];
    [cloudBtn setImage:[UIImage imageNamed:@"Bottom_Cloud_highlight"] forState:UIControlStateHighlighted];
    [cloudBtn addTarget:self action:@selector(cloudBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:photoBtn];
    photoBtn.exclusiveTouch = YES;
    _photoBtn = photoBtn;
    [photoBtn setImage:[UIImage imageNamed:@"Bottom_Camera"] forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"Bottom_Camera_highlight"] forState:UIControlStateHighlighted];
    [photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:pauseBtn];
    pauseBtn.exclusiveTouch = YES;
    _pauseBtn = pauseBtn;
    _pauseBtn.alpha = 0.0f;
    
    [pauseBtn setImage:[UIImage imageNamed:@"Bottom_Pause"] forState:UIControlStateNormal];
    [pauseBtn setImage:[UIImage imageNamed:@"Bottom_Pause_highlight"] forState:UIControlStateHighlighted];
    [pauseBtn addTarget:self action:@selector(pauseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupConstrains
{
    [self.recBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        
    }];
}

#pragma mark - response
- (void)cloudBtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(cloudBtnClicked)]) {
        [self.delegate cloudBtnClicked];
    }
}

- (void)photoBtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(photoBtnClicked:)]) {
        [self.delegate photoBtnClicked:_recording];
    }
}

- (void)pauseBtnClick:(UIButton *)btn
{
    _pausing = !_pausing;
    if (_pausing) {
        [_pauseBtn setImage:[UIImage imageNamed:@"Bottom_Resum"] forState:UIControlStateNormal];
        [_pauseBtn setImage:[UIImage imageNamed:@"Bottom_Resum_highlight"] forState:UIControlStateHighlighted];
        [self setNeedsLayout];
    } else {
        [_pauseBtn setImage:[UIImage imageNamed:@"Bottom_Pause"] forState:UIControlStateNormal];
        [_pauseBtn setImage:[UIImage imageNamed:@"Bottom_Pause_highlight"] forState:UIControlStateHighlighted];
        [self setNeedsLayout];
        
    }
    
    
    if ([self.delegate respondsToSelector:@selector(pauseBtnClicked:)]) {
        [self.delegate pauseBtnClicked:_pausing];
    }
    
}

@end
