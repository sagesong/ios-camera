//
//  testCollectionViewCell.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/19.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "testCollectionViewCell.h"
#import "Masonry.h"

@interface testCollectionViewCell ()

@property (nonatomic, weak) UIView *iconView;
@property (nonatomic, assign) BOOL isMoving;
@end

@implementation testCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor blueColor];
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        self.iconView = view;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
        
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longTap.allowableMovement = CGFLOAT_MAX;
        [self addGestureRecognizer:longTap];
    }
    return self;
}

- (void)longPress:(UILongPressGestureRecognizer *)ges
{
    NSLog(@"long gesture happen");
    if ([self.iconView.superview isKindOfClass:[testCollectionViewCell class]]) {
        testCollectionViewCell *cell = (testCollectionViewCell *)self.iconView.superview;
        self.iconView.tag = cell.tag;
    }
    CGPoint touch = [ges locationInView:self.collectionView];
    NSLog(@"point %@",NSStringFromCGPoint(touch));
    if (!self.isMoving) {
        [self.collectionView addSubview:self.iconView];
        self.isMoving = YES;
    }
    self.iconView.center = touch;
    
    
    if (ges.state == UIGestureRecognizerStateEnded) {
//        [self.collectionView reloadData];
        self.isMoving = NO;
    }
}

@end
