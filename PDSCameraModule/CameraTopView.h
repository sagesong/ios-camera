//
//  CameraTopView.h
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CameraTopViewDelegate <NSObject>

@optional
- (void)backBtnClicked;
- (void)flashBtnClicked:(BOOL)enableFlash;
- (void)microBtnClicked:(BOOL)enableMicro;
- (void)switchBtnClicked;

@end


@interface CameraTopView : UIView

@property (nonatomic, weak) id<CameraTopViewDelegate> delegate;

@end
