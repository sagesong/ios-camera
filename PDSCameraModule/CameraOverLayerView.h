//
//  CameraOverLayerView.h
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraTopView.h"
#import "CameraBottomView.h"
@interface CameraOverLayerView : UIView

@property (nonatomic,weak) CameraTopView *topView;
@property (nonatomic,weak) CameraBottomView *bottomView;
@end
