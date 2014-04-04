//
//  AJKMainViewController.h
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-4.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "TableViewMenu.h"
#import "TableMenuCell.h"

@interface AJKMainViewController : TableViewMenu<UITableViewDataSource,UITableViewDelegate>

-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum;

@end
