//
//  CameraView.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "CameraView.h"
@implementation CameraView

+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

- (void)setSession:(AVCaptureSession *)session {
    [(AVCaptureVideoPreviewLayer*)self.layer setSession:session];
}

@end
