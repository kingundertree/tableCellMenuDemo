//
//  AJKMainViewController.m
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-2.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "AJKMainViewController.h"

@interface AJKMainViewController (){
    NSMutableArray *listData;
}

@end

@implementation AJKMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        listData = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"TableViewMenuCell";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tableList.delegate = self;
    tableList.dataSource = self;
    [self.view addSubview:tableList];
}
-(void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum{
    NSLog(@"你选择了第 %d 行第 %d 个菜单",cellIndexNum+1,menuIndexNum+1);
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [listData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    
    TableMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[TableMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.chooseDelegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configWithData:indexPath cellFrame:CGRectMake(0, 0, 320, 44)];


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
