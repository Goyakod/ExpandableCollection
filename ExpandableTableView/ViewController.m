//
//  ViewController.m
//  ExpandableTableView
//
//  Created by pro on 16/3/17.
//  Copyright © 2016年 Founder. All rights reserved.
//

#import "ViewController.h"

#pragma mark - collectionViewHeaderView
@interface collectionViewHeaderView()

@end

@implementation collectionViewHeaderView

@end


#pragma mark - ViewController

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    NSMutableArray *_dataArray;
    
    NSMutableArray *_section0;
    
    NSMutableArray *_section1;
    
    NSMutableArray *_section2;
    
    NSArray *_emptyArray;
    
    NSArray *_statusArray;
    
    BOOL _firstIsExpand;
    
    BOOL _secondIsExpand;
    
    BOOL _thirdIsExpand;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _emptyArray = [NSArray array];
    
    _section0 = [NSMutableArray arrayWithObjects:@"000",@"001", @"002",@"003",nil];
    _section1 = [NSMutableArray arrayWithObjects:@"100",@"101", @"102",@"103",@"104",nil];
    _section2 = [NSMutableArray arrayWithObjects:@"200",@"201", @"202",@"203",@"204",@"205",nil];
    
    _dataArray = [NSMutableArray arrayWithObjects:_section0,_section1,_section2 ,nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 250) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[collectionViewHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionViewHeaderView"];
    [self.view addSubview:self.collectionView];
    
}

#pragma mark collectionView Datasource Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *sectionArray = [_dataArray objectAtIndex:section];
    switch (section) {
        case 0:
            return _firstIsExpand ? sectionArray.count : 0;
            break;
        case 1:
            return _secondIsExpand ? sectionArray.count : 0;
            break;
        case 2:
            return _thirdIsExpand ? sectionArray.count : 0;
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *sectionArray = [_dataArray objectAtIndex:indexPath.section];
    
    cell.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.textColor = [UIColor blackColor];
    label.text = [sectionArray objectAtIndex:indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.frame.size.width, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"collectionViewHeaderView";
    collectionViewHeaderView *header = (collectionViewHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedItemAtIndex:)];
    header.hostView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, header.frame.size.width, header.frame.size.height)];
    [header.hostView addGestureRecognizer:tap];
    header.hostView.tag = indexPath.section;
    
    header.hostView.backgroundColor = [UIColor redColor];
    
    header.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, header.frame.size.height - 10)];
    header.titleLabel.textColor = [UIColor greenColor];
    
    //图片暂时不设置
    header.imageView = [[UIImageView alloc] init];
    
    [header addSubview:header.hostView];
    [header.hostView addSubview:header.titleLabel];
    [header.hostView addSubview:header.imageView];
    
    switch (indexPath.section) {
        case 0:
            header.titleLabel.text = @"Group 0";
            break;
        case 1:
            header.titleLabel.text = @"Group 1";
            break;
        case 2:
            header.titleLabel.text = @"Group 2";
            break;
    }
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Item选择了:%ld",indexPath.row);
}


- (void)selectedItemAtIndex:(UIGestureRecognizer *)guesture
{
    NSInteger sectionIndex = guesture.view.tag;
    
    switch (sectionIndex) {
        case 0:
            _firstIsExpand = !_firstIsExpand;
            
            break;
        case 1:
            _secondIsExpand = !_secondIsExpand;
            
            break;
        case 2:
            _thirdIsExpand = !_thirdIsExpand;
        
            break;
    }
    
    [self.collectionView reloadData];
}


#pragma mark tableView Delegate Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = [_dataArray objectAtIndex:section];
    return sectionArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return @"分组1";
        case 1:
            return @"分组2";
        case 2:
            return @"分组3";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *sectionArray = [_dataArray objectAtIndex:indexPath.section];
    cell.textLabel.text = [sectionArray objectAtIndex:indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectedSectionAnIndex:)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor grayColor];
    view.tag = section;
    [view addGestureRecognizer:tap];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
    [view addSubview:titleLabel];
    
    switch (section) {
        case 0:
            titleLabel.text = @"分组1";
            break;
        case 1:
            titleLabel.text = @"分组2";
            break;
        case 2:
            titleLabel.text = @"分组3";
            break;
    }
    
    return view;
}


- (void)didSelectedSectionAnIndex:(UIGestureRecognizer *)gesture
{
    NSInteger sectionIndex = gesture.view.tag;

    switch (sectionIndex) {
        case 0:
            _firstIsExpand = !_firstIsExpand;
            if (_firstIsExpand) {
                [_dataArray replaceObjectAtIndex:sectionIndex withObject:_emptyArray];
            }else{
                [_dataArray replaceObjectAtIndex:sectionIndex withObject: _section0];
            }
            break;
        case 1:
            _secondIsExpand = !_secondIsExpand;
            if (_secondIsExpand) {
                [_dataArray replaceObjectAtIndex:sectionIndex withObject:_emptyArray];
            }else{
                [_dataArray replaceObjectAtIndex:sectionIndex withObject:_section1];
            }
            break;
        case 2:
            _thirdIsExpand = !_thirdIsExpand;
            if (_thirdIsExpand) {
                [_dataArray replaceObjectAtIndex:sectionIndex withObject:_emptyArray];
            }else{
                [_dataArray replaceObjectAtIndex:sectionIndex withObject:_section2];
            }
            break;
    }
    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
