//
//  CameraView.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "CameraView.h"
@implementation CameraView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    
    return self;
}

+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

- (void)setSession:(AVCaptureSession *)session {
    [(AVCaptureVideoPreviewLayer*)self.layer setSession:session];
}

@end
