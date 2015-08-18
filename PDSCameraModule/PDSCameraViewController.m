//
//  PdSCameraViewController.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "PDSCameraViewController.h"
#import "CameraView.h"
#import "CameraSessionManage.h"
#import "CameraOverLayerView.h"
#import "Masonry.h"
@interface PDSCameraViewController ()<CameraTopViewDelegate>

@property (nonatomic, strong) CameraSessionManage *manager;

@end

@implementation PDSCameraViewController

- (void)loadView
{
    self.view = [[CameraView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CameraSessionManage *manage = [[CameraSessionManage alloc] init];
    self.manager = manage;
    CameraView *cameraView = (CameraView *)self.view;
    [cameraView setSession:manage.session];
    CameraOverLayerView *overLayer = [[CameraOverLayerView alloc] init];
    overLayer.topView.delegate = self;
    [self.view addSubview:overLayer];

    [overLayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.manager startRunning];
    [UIApplication sharedApplication].statusBarHidden = YES;
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

#pragma mark - Camera view delegate
- (void)backBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)flashBtnClicked:(BOOL)enableFlash
{
    
}
- (void)microBtnClicked:(BOOL)enableMicro
{
    
}
- (void)switchBtnClicked
{
    [self.manager switchCamera];
}



@end
