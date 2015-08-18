//
//  CameraBottomView.h
//  PDSCameraModule
//
//  Created by Lightning on 15/8/18.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraBottomViewDelegate <NSObject>

@optional

- (void)recBtnClicked:(BOOL)recording;
- (void)cloudBtnClicked;
- (void)photoBtnClicked:(BOOL)recording;
- (void)pauseBtnClicked:(BOOL)pausing;



@end

@interface CameraBottomView : UIView

@property (nonatomic, weak) id<CameraBottomViewDelegate> delegate;
@property (nonatomic, assign, getter=isPausing,readonly) BOOL pausing;

@end
