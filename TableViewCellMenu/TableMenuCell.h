//
//  TableMenuCell.h
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-2.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableMenuCell;

@protocol menuActionDelegate <NSObject>

- (void)tableMenuDidShowInCell:(TableMenuCell *)cell;
- (void)tableMenuWillShowInCell:(TableMenuCell *)cell;
- (void)tableMenuDidHideInCell:(TableMenuCell *)cell;
- (void)tableMenuWillHideInCell:(TableMenuCell *)cell;

- (void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum;
@end

@interface TableMenuCell : UITableViewCell<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, assign) float startX;
@property (nonatomic, assign) float cellX;
@property (nonatomic, assign) id<menuActionDelegate>menuActionDelegate;
@property (nonatomic, strong) NSIndexPath *indexpathNum;
@property (nonatomic, assign) int menuCount;

-(void)configWithData:(NSIndexPath *)indexPath menuData:(NSArray *)menuData cellFrame:(CGRect)cellFrame;
- (void)setMenuHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler;
@end
