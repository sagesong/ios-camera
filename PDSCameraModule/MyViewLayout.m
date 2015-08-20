//
//  MyViewLayout.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/20.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "MyViewLayout.h"

@implementation MyViewLayout

- (CGSize)collectionViewContentSize
{
    return CGSizeZero;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return nil;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
