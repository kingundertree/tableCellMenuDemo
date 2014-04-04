//
//  TableMenuCell.h
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-2.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol menuChooseDelegate <NSObject>
-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum;
@end

@interface TableMenuCell : UITableViewCell<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, assign) float startX;
@property (nonatomic, assign) float cellX;
@property (nonatomic, assign) id<menuChooseDelegate>chooseDelegate;
@property (nonatomic, strong) NSIndexPath *indexpathNum;
@property (nonatomic, assign) int menuCount;

-(void)configWithData:(NSIndexPath *)indexPath menuData:(NSArray *)menuData cellFrame:(CGRect)cellFrame;

@end
