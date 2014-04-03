//
//  TableMenuCell.m
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-2.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "TableMenuCell.h"


#define ISIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

@implementation TableMenuCell
@synthesize cellView;
@synthesize startX;
@synthesize cellX;
@synthesize chooseDelegate;
@synthesize indexpathNum;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.cellView = [[UIView alloc] init];
        self.cellView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.cellView];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cellPanGes:)];
        panGes.delegate = self;
        panGes.delaysTouchesBegan = YES;
        panGes.cancelsTouchesInView = NO;
        [self addGestureRecognizer:panGes];
    }
    return self;
}
-(void)configWithData:(NSIndexPath *)indexPath cellFrame:(CGRect)cellFrame{
    indexpathNum = indexPath;
    if (self.cellView) {
        [self.cellView removeFromSuperview];
        self.cellView = nil;
    }
    self.cellView = [[UIView alloc] init];
    self.cellView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cellView];

    self.cellView.frame = cellFrame;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = [NSString stringWithFormat:@"我就是我,颜色不一样的火焰--->>%d",indexpathNum.row];
    lab.font = [UIFont systemFontOfSize:16];
    lab.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    lab.textColor = [UIColor whiteColor];
    [self.cellView addSubview:lab];

    UIView *btnView = [[UIView alloc] init];
    btnView.frame = CGRectMake(160, 0, 160, 80);
    btnView.backgroundColor = [UIColor clearColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 80, 80);
    btn1.tag = 0;
    [btn1 addTarget:self action:@selector(menuBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor lightGrayColor];
    [btn1 setTitle:@"share" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnView addSubview:btn1];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(80, 0, 80, 80);
    btn2.tag = 1;
    [btn2 addTarget:self action:@selector(menuBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"delete" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnView addSubview:btn2];
    
    [self.contentView insertSubview:btnView belowSubview:self.cellView];
}
-(void)menuBtnClick1:(id)sender{
    UIButton *btn = sender;
    [chooseDelegate menuChooseIndex:indexpathNum.row menuIndexNum:btn.tag];
    
//    UITableViewCell *cell;
//    if (ISIOS7) {
//        cell = (UITableViewCell *)btn.superview.superview;
//    }else{
//        cell = (UITableViewCell *)btn.superview;
//    }
}
-(void)menuBtnClick2:(id)sender{
    UIButton *btn = sender;
    [chooseDelegate menuChooseIndex:indexpathNum.row menuIndexNum:btn.tag];
}
-(void)cellPanGes:(UIPanGestureRecognizer *)panGes{
    CGPoint pointer = [panGes locationInView:self.contentView];
    if (panGes.state == UIGestureRecognizerStateBegan) {
        startX = pointer.x;
        cellX = self.cellView.frame.origin.x;
    }else if (panGes.state == UIGestureRecognizerStateEnded){
        [self cellReset:pointer.x - startX];
        return;
    }else if (panGes.state == UIGestureRecognizerStateCancelled){
        [self cellReset:pointer.x - startX];
        return;
    }
    [self cellViewMoveToX:cellX + pointer.x - startX];
}
-(void)cellReset:(float)moveX{
    if (cellX <= -160) {
        if (moveX <= 0) {
            return;
        }else if(moveX > 20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
            }];
        }else if (moveX <= 20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:-160];
            } completion:^(BOOL finished) {
            }];
        }
    }else{
        if (moveX >= 0) {
            return;
        }else if(moveX < -20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:-160];
            } completion:^(BOOL finished) {
            }];
        }else if (moveX >= -20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
            }];
        }
    }
}
-(void)cellViewMoveToX:(float)x{
    if (x <= -180) {
        x = -180;
    }else if (x >= 50){
        x = 50;
    }
    self.cellView.frame = CGRectMake(x, 0, 320, 80);
    if (x == -180) {
        [UIView animateWithDuration:0.2 animations:^{
            [self initCellFrame:-160];
        } completion:^(BOOL finished) {
        }];
    }
    if (x == 50) {
        [UIView animateWithDuration:0.2 animations:^{
            [self initCellFrame:0];
        } completion:^(BOOL finished) {
        }];
    }
}
- (void)initCellFrame:(float)x{
    CGRect frame = self.cellView.frame;
    frame.origin.x = x;
    
    self.cellView.frame = frame;
}
#pragma mark * UIPanGestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return fabs(translation.x) > fabs(translation.y);
    }
    return YES;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
