//
//  CameraSessionManage.h
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@protocol CameraSessionManageDelegate <NSObject>

@optional
- (void)outputSameplebuffer:(CMSampleBufferRef)sampleBuffer connection:(AVCaptureConnection *)connection;

@end

@interface CameraSessionManage : NSObject

@property (nonatomic, weak) id<CameraSessionManageDelegate> delegate;
@property (nonatomic, readonly) AVCaptureSession *session;
@property (nonatomic, readonly) BOOL isRunning;
@property (nonatomic, readonly) BOOL isPausing;

@property (nonatomic) BOOL enableFlash;
@property (nonatomic) BOOL enalbeMicro;

- (void)switchCamera;

- (void)takeSnap;
- (void)startRunning;
- (void)pauseRunning;
- (void)stopRunning;

- (instancetype)initSessionWithPreset:(NSString *)sessionPreset;

@end
