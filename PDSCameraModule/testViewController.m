//
//  testViewController.m
//  PDSCameraModule
//
//  Created by Lightning on 15/8/19.
//  Copyright (c) 2015年 Lightning. All rights reserved.
//

#import "testViewController.h"
#import "testCollectionViewCell.h"
@interface testViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [collection registerClass:[testCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collection.dataSource = self;
    collection.delegate = self;
    collection.backgroundColor = [UIColor redColor];
    [self.view addSubview:collection];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    testCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.collectionView = collectionView;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell clicked- %d--%d",indexPath.section,indexPath.row);
}

@end
