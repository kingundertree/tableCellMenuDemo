//
//  TableViewMenu.m
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-4.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "TableViewMenu.h"

@interface TableViewMenu ()

@property (nonatomic, strong) TableMenuCell *activeCell;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) OverLayView *overLayView;
@end

@implementation TableViewMenu
@synthesize isAllowScroll;
@synthesize editingCellNum;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.isEditing = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum{
    
}
- (void)menuDeleteCellSuc:(TableMenuCell *)cell{
    [cell.superview sendSubviewToBack:cell];
    self.isEditing = NO;
}
- (void)deleteCell:(TableMenuCell *)cell{
    [cell.superview sendSubviewToBack:cell];
    self.isEditing = NO;
}
- (void)setIsEditing:(BOOL)isEditing{
    if (_isEditing != isEditing) {
        _isEditing = isEditing;
    }
//    if (self.isAllowScroll != TableIsScroll) {
//        self.tableView.scrollEnabled = !isEditing;
//    }
    if (isAllowScroll == TableIsScroll) {
        return;
    }

    if (_isEditing) {
        if (!_overLayView) {
            _overLayView = [[OverLayView alloc] initWithFrame:self.view.bounds];
//            _overLayView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:.1];
            _overLayView.backgroundColor = [UIColor clearColor];
            _overLayView.delegate = self;
            [self.view addSubview:_overLayView];
        }
    }else{
        self.activeCell = nil;
        [_overLayView removeFromSuperview];
        _overLayView = nil;
    }
}
- (UIView *)overLayView:(OverLayView *)view didHitPoint:(CGPoint)didHitPoint withEvent:(UIEvent *)withEvent{
    BOOL shoudReceivePointTouch = YES;
    
    CGPoint location = [self.view convertPoint:didHitPoint fromView:view];
    CGRect rect = [self.view  convertRect:self.activeCell.frame toView:self.view];
    shoudReceivePointTouch = CGRectContainsPoint(rect, location);
    if (!shoudReceivePointTouch) {
        [self hideMenuActive:YES];
    }
    
    return (shoudReceivePointTouch) ? [self.activeCell hitTest:didHitPoint withEvent:withEvent] : view;
}

- (void)hideMenuActive:(BOOL)aninated{
    __block TableViewMenu *tableViewMenu = self;
    [self.activeCell setMenuHidden:YES animated:YES completionHandler:^{
        tableViewMenu.isEditing = NO;
    }];
}
- (void)tableMenuDidShowInCell:(TableMenuCell *)cell{
    self.editingCellNum = [self.tableView indexPathForCell:cell].row;
    self.isEditing = YES;
    self.activeCell = cell;
}
- (void)tableMenuWillShowInCell:(TableMenuCell *)cell{
    self.editingCellNum = [self.tableView indexPathForCell:cell].row;
    self.isEditing = YES;
    self.activeCell = cell;
}
- (void)tableMenuDidHideInCell:(TableMenuCell *)cell{
    self.editingCellNum = -1;
    self.isEditing = NO;
    self.activeCell = nil;
}
- (void)tableMenuWillHideInCell:(TableMenuCell *)cell{
    self.editingCellNum = -1;
    self.isEditing = NO;
    self.activeCell = nil;
}

#pragma mark * UITableView delegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView cellForRowAtIndexPath:indexPath] == self.activeCell) {
        [self hideMenuActive:YES];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
