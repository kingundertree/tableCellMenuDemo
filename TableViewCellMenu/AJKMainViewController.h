//
//  AJKMainViewController.h
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-2.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableMenuCell.h"
#import "TableViewMenu.h"

@interface AJKMainViewController : TableViewMenu<UITableViewDataSource,UITableViewDelegate,menuChooseDelegate>

-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum;

@end
