//
//  testViewController.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/19.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "testViewController.h"
#import "testCollectionViewCell.h"
#import "CellModel.h"
#import "Masonry.h"
@interface testViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, weak) UICollectionView *collection;
@property (nonatomic, weak) UIView *currentView;
@property (nonatomic, strong) NSIndexPath *movingIndex;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

@property (nonatomic, strong) CellModel *selectedModle;
@property (nonatomic, strong) CellModel *movingModel;

@property (nonatomic, assign) BOOL  animating;
@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.view addSubview:collection];
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [collection registerClass:[testCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collection.dataSource = self;
    collection.delegate = self;
    collection.backgroundColor = [UIColor redColor];
    self.models = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        CellModel *model = [[CellModel alloc] init];
        model.indexString = [NSString stringWithFormat:@"%2d",i];
        [self.models addObject:model];
    }
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//    [collection addGestureRecognizer:tap];
    self.collection = collection;
    
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [collection addGestureRecognizer:longTap];
    longTap.allowableMovement = CGFLOAT_MAX;
    [self.collection reloadData];
}

- (void)longPress:(UILongPressGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateBegan) {
        CGPoint initiatialPoint = [ges locationInView:self.collection];
        NSIndexPath *indexPath = [self.collection indexPathForItemAtPoint:initiatialPoint];
        self.selectedIndex = indexPath;
        self.movingIndex = indexPath;
        CellModel *modle = self.models[indexPath.row];
        self.selectedModle = [[CellModel alloc] init];
        self.selectedModle.indexString = modle.indexString;
        
        UIView *cell = [self.collection cellForItemAtIndexPath:indexPath];
        testCollectionViewCell *view = [[testCollectionViewCell alloc] initWithFrame:cell.frame];
        self.currentView = view;
        view.backgroundColor = [UIColor blueColor];
        view.lable.text = modle.indexString;
        [self.collection addSubview:view];
        
        modle.indexString = @"";
        [self.collection reloadItemsAtIndexPaths:@[indexPath]];
    } else if (ges.state == UIGestureRecognizerStateChanged){
        
        CGPoint changePoint = [ges locationInView:self.collection];
        self.currentView.center = changePoint;
        if (self.animating) {
            return;
        }
        NSIndexPath *index = [self.collection indexPathForItemAtPoint:changePoint];
        if (index) {
            NSLog(@"someone");
            // layout
            if (!self.movingIndex || (self.movingIndex.row != index.row && self.selectedIndex)) {
//                if (index.row < self.selectedIndex.row) {
                    [self.models removeObjectAtIndex:self.selectedIndex.row];
                    self.movingIndex = index;
                    CellModel *modle = [[CellModel alloc] init];
                    modle.indexString = @"";
                    [self.models insertObject:modle atIndex:index.row];
                self.animating = YES;
                    [self.collection performBatchUpdates:^{
                        if (index.row < self.selectedIndex.row) {
                            for (NSInteger i = index.row; i < self.selectedIndex.row; i++) {
                                NSIndexPath *from = [NSIndexPath indexPathForItem:i inSection:0];
                                NSIndexPath *to = [NSIndexPath indexPathForItem:i + 1 inSection:0];
                                [self.collection moveItemAtIndexPath:from toIndexPath:to];
                            }
                        } else if (index.row > self.selectedIndex.row) {
                            for (NSInteger i = self.selectedIndex.row + 1; i <= index.row ; i++) {
                                NSIndexPath *from = [NSIndexPath indexPathForItem:i inSection:0];
                                NSIndexPath *to = [NSIndexPath indexPathForItem:i - 1 inSection:0];
                                [self.collection moveItemAtIndexPath:from toIndexPath:to];
                            }
                        }
                        
                    } completion:^(BOOL finished) {
                        self.selectedIndex = self.movingIndex;
                        self.animating = NO;
                    }];
//                }
            }
            
        }
    } else if (ges.state == UIGestureRecognizerStateEnded)
    {
        UIView *view = [self.collection cellForItemAtIndexPath:self.movingIndex];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = view.frame;
        } completion:^(BOOL finished) {
//            [self.models insertObject:self.selectedModle atIndex:self.selectedIndex.row + 1];
//            [self.models removeObjectAtIndex:self.selectedIndex.row - 1];
            CellModel *modle = self.models[self.movingIndex.row];
            modle.indexString = self.selectedModle.indexString;
            [self.collection reloadItemsAtIndexPaths:@[self.movingIndex]];
            [self.currentView removeFromSuperview];
        }];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    testCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"forIndexPath:indexPath];
    cell.tag = indexPath.row;
    CellModel *modle = self.models[indexPath.row];
    cell.lable.text = modle.indexString;
    NSLog(@"---%@",modle.indexString);
    cell.collectionView = collectionView;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell clicked- %d--%d",indexPath.section,indexPath.row);
}


- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self.models removeObjectAtIndex:10];
        [self.collection deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
    }
}

@end
