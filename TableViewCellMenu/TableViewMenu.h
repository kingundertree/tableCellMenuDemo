//
//  TableViewMenu.h
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-4.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableMenuCell.h"
#import "OverLayView.h"

typedef enum{
    TableIsScroll = 0,
    TableIsForbiddenScroll
}IsAllowScroll;

@interface TableViewMenu : UITableViewController<menuActionDelegate,OverLayViewDelegate>

@property(nonatomic, assign) IsAllowScroll isAllowScroll;
@property(nonatomic, assign) NSInteger editingCellNum;
@end
