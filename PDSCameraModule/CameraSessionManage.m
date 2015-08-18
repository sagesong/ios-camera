//
//  CameraSessionManage.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "CameraSessionManage.h"
@interface CameraSessionManage ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>
@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCaptureDeviceInput *videoDeviceInput;
@property (nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic) dispatch_queue_t cameraDataQueue;
@property (nonatomic) dispatch_queue_t sessionQueue;

@property (nonatomic, copy) NSString *sessionPreset;

@end


@implementation CameraSessionManage
#pragma mark - Life cycle
- (instancetype)init
{
    if (self = [super init]) {
        [self setupSessionContext];
    }
    return self;
}

- (instancetype)initSessionWithPreset:(NSString *)sessionPreset
{
    _sessionPreset = sessionPreset;
    if (self = [super init]) {
        [self setupSessionContext];
    }
    return self;
    
}

- (BOOL)setupSessionContext
{
    // configure AVCaptureSession
    self.session = [[AVCaptureSession alloc] init];
    if (_sessionPreset) {
        if ([self.session canSetSessionPreset:_sessionPreset]) {
            [self.session setSessionPreset:_sessionPreset];
        }
    } else {
        if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
            [self.session setSessionPreset:AVCaptureSessionPreset1280x720];
        } else {
            [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        }
    }
    dispatch_queue_t session = dispatch_queue_create("sessionQueue ", DISPATCH_QUEUE_SERIAL);
    [self setSessionQueue:session];
    [self setupVideoInputAndOutput];
    [self setupAudeoInputAndOutput];
    
    // still image capture
    AVCaptureStillImageOutput *stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    if ([self.session canAddOutput:stillImageOutput])
    {
        [stillImageOutput setOutputSettings:@{AVVideoCodecKey : AVVideoCodecJPEG}];
        [self.session addOutput:stillImageOutput];
        [self setStillImageOutput:stillImageOutput];
    }
    
    
    return YES;
}


- (void)switchCamera
{
    dispatch_async(self.sessionQueue, ^{
        AVCaptureDevice *currentVideoDevice = [[self videoDeviceInput] device];
        AVCaptureDevicePosition preferredPosition = AVCaptureDevicePositionUnspecified;
        AVCaptureDevicePosition currentPosition = [currentVideoDevice position];
        
        switch (currentPosition)
        {
            case AVCaptureDevicePositionUnspecified:
                preferredPosition = AVCaptureDevicePositionBack;
                break;
            case AVCaptureDevicePositionBack:
                preferredPosition = AVCaptureDevicePositionFront;
                break;
            case AVCaptureDevicePositionFront:
                preferredPosition = AVCaptureDevicePositionBack;
                break;
        }
        
        AVCaptureDevice *videoDevice = [CameraSessionManage deviceWithMediaType:AVMediaTypeVideo preferringPosition:preferredPosition];
        AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
        
        [[self session] beginConfiguration];
        
        [[self session] removeInput:[self videoDeviceInput]];
        if ([[self session] canAddInput:videoDeviceInput])
        {
            [[self session] addInput:videoDeviceInput];
            [self setVideoDeviceInput:videoDeviceInput];
        }
        else
        {
            [[self session] addInput:[self videoDeviceInput]];
        }
        [[self session] commitConfiguration];
    });
}

- (void)takeSnap
{
    
}
- (void)startRunning
{
    if (self.session.isRunning) {
        return;
    }
//    dispatch_async(self.sessionQueue, ^{
        [self.session startRunning];
//    });
    
}

- (void)pauseRunning
{
    
}

- (void)stopRunning
{
    if (self.session.isRunning) {
        dispatch_async(self.sessionQueue, ^{
            [self.session stopRunning];
        });
    }
    
}

#pragma private method
+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = [devices firstObject];
    
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position)
        {
            captureDevice = device;
            break;
        }
    }
    
    return captureDevice;
}

- (void)setupVideoInputAndOutput
{
    // add videoDeviceInput and audioDeviceInput
    NSError *error = nil;
    AVCaptureDevice *videoDevice = [CameraSessionManage deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionBack];
    AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (error)
    {
        NSLog(@"videoDeviceInput---%@", error);
    }
    if ([self.session canAddInput:videoDeviceInput]) {
        [self.session addInput:videoDeviceInput];
        [self setVideoDeviceInput:videoDeviceInput];
    } else {
        NSLog(@"videoDeviceInput can't be added");
    }
    dispatch_queue_t dataQueue = dispatch_queue_create("dataQueue ", DISPATCH_QUEUE_SERIAL);
    [self setCameraDataQueue:dataQueue];
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoDataOutput setSampleBufferDelegate:self queue:dataQueue];
    if ([self.session canAddOutput:videoDataOutput]) {
        [self.session addOutput:videoDataOutput];
        [self setVideoDataOutput:videoDataOutput];
    } else {
        NSLog(@"videoDataOutput can't be added");
    }
}

- (void)setupAudeoInputAndOutput
{
    NSError *error = nil;
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
    if (error) {
        NSLog(@"Failed to alloc audioDeviceInput");
    }
    if ([self.session canAddInput:audioDeviceInput]){
        [self.session addInput:audioDeviceInput];
    } else {
        NSLog(@"audioDeviceInput can't be added");
    }
    
    AVCaptureAudioDataOutput *audioDataOutput = [[AVCaptureAudioDataOutput alloc] init];
    [audioDataOutput setSampleBufferDelegate:self queue:self.cameraDataQueue];
    if ([self.session canAddOutput:audioDataOutput]) {
        [self.session addOutput:audioDataOutput];
    } else {
        NSLog(@"audioDataOutput can't be added");
    }
}

#pragma -protocol
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if ([self.delegate respondsToSelector:@selector(outputSameplebuffer:connection:)]) {
        [self.delegate outputSameplebuffer:sampleBuffer connection:connection];
    }
}

@end
