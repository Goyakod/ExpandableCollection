//
//  ViewController.h
//  ExpandableTableView
//
//  Created by pro on 16/3/17.
//  Copyright © 2016年 Founder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectionViewHeaderView : UICollectionReusableView

@property (nonatomic, strong) UIView      *hostView;
@property (nonatomic,strong ) UILabel     *titleLabel;
@property (nonatomic,strong ) UIImageView *imageView;

@end


@interface ViewController : UIViewController

@property (nonatomic,strong) UITableView      *tableView;

@property (nonatomic,strong) UICollectionView *collectionView;

@end

