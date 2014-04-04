//
//  TableMenuCell.m
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-2.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "TableMenuCell.h"

@interface TableMenuCell () 
//@property (assign, nonatomic, getter = isMenuViewHidden) BOOL menuViewHidden;
@end

#define ISIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

@implementation TableMenuCell
@synthesize cellView;
@synthesize startX;
@synthesize cellX;
@synthesize menuActionDelegate;
@synthesize indexpathNum;
@synthesize menuCount;
@synthesize menuView;
@synthesize menuViewHidden;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        menuCount = 0;
        
        self.cellView = [[UIView alloc] init];
        self.cellView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.cellView];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cellPanGes:)];
        panGes.delegate = self;
        panGes.delaysTouchesBegan = YES;
        panGes.cancelsTouchesInView = NO;
        [self addGestureRecognizer:panGes];
    }
    return self;
}
-(void)configWithData:(NSIndexPath *)indexPath menuData:(NSArray *)menuData cellFrame:(CGRect)cellFrame{
    indexpathNum = indexPath;
    menuCount = [menuData count];
    if (self.cellView) {
        [self.cellView removeFromSuperview];
        self.cellView = nil;
    }
    self.cellView = [[UIView alloc] init];
    self.cellView.backgroundColor = [UIColor whiteColor];
    self.cellView.frame = cellFrame;
    [self.contentView addSubview:self.cellView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = [NSString stringWithFormat:@"||^^<>^^我就是我,颜色不一样的火焰>>%d",indexpathNum.row];
    lab.font = [UIFont systemFontOfSize:16];
//    lab.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    lab.backgroundColor = [UIColor whiteColor];
    lab.textColor = [UIColor blackColor];
    [self.cellView addSubview:lab];
    
    menuView = [[UIView alloc] init];
    menuView.frame = CGRectMake(320 - 80*[menuData count], 0, 80*[menuData count], cellFrame.size.height);
    menuView.backgroundColor = [UIColor clearColor];
    [self.contentView insertSubview:menuView belowSubview:self.cellView];
//    [self.contentView insertSubview:menuView aboveSubview:self.cellView];
    
    self.menuViewHidden = YES;

    for (int i = 0; i < menuCount; i++) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
        bgView.frame = CGRectMake(80*i, 0, 80, cellFrame.size.height);
        [menuView addSubview:bgView];
        
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        menuBtn.frame = CGRectMake((80 - 40)/2, (cellFrame.size.height - 40)/2, 40, 40);
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[menuData objectAtIndex:i] objectForKey:@"stateNormal"]]] forState:UIControlStateNormal];
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[[menuData objectAtIndex:i] objectForKey:@"stateHighLight"]]] forState:UIControlStateHighlighted];
        [bgView addSubview:menuBtn];
    }
}
-(void)menuBtnClick:(id)sender{
    UIButton *btn = sender;
    if (btn.tag == 2) {
        self.menuViewHidden = YES;
        [menuActionDelegate deleteCell:self];
    }
    [self.menuActionDelegate menuChooseIndex:indexpathNum.row menuIndexNum:btn.tag];
    
//    UITableViewCell *cell;
//    if (ISIOS7) {
//        cell = (UITableViewCell *)btn.superview.superview;
//    }else{
//        cell = (UITableViewCell *)btn.superview;
//    }
}

-(void)cellPanGes:(UIPanGestureRecognizer *)panGes{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGPoint pointer = [panGes locationInView:self.contentView];
    if (panGes.state == UIGestureRecognizerStateBegan) {
        self.menuViewHidden = NO;
        startX = pointer.x;
        cellX = self.cellView.frame.origin.x;
    }else if (panGes.state == UIGestureRecognizerStateChanged){
        self.menuViewHidden = NO;
        [menuActionDelegate tableMenuWillShowInCell:self];
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
    if (cellX <= -80*menuCount) {
        if (moveX <= 0) {
            return;
        }else if(moveX > 20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                self.menuViewHidden = YES;
                [self.menuActionDelegate tableMenuDidHideInCell:self];
            }];
        }else if (moveX <= 20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:-menuCount*80];
            } completion:^(BOOL finished) {
                self.menuViewHidden = NO;
                [self.menuActionDelegate tableMenuDidShowInCell:self];
            }];
        }
    }else{
        if (moveX >= 0) {
            return;
        }else if(moveX < -20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:-menuCount*80];
            } completion:^(BOOL finished) {
                self.menuViewHidden = NO;
                NSLog(@"self.menuViewHidden---3>>%d",self.menuViewHidden);
                [self.menuActionDelegate tableMenuDidShowInCell:self];
            }];
        }else if (moveX >= -20){
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                self.menuViewHidden = YES;
                NSLog(@"self.menuViewHidden---4>>%d",self.menuViewHidden);
                [self.menuActionDelegate tableMenuDidShowInCell:self];
            }];
        }
    }
}
-(void)cellViewMoveToX:(float)x{
    if (x <= -(menuCount*80+20)) {
        x = -(menuCount*80+20);
    }else if (x >= 50){
        x = 50;
    }
    self.cellView.frame = CGRectMake(x, 0, 320, 80);
    if (x == -(menuCount*80+20)) {
        [UIView animateWithDuration:0.2 animations:^{
            [self initCellFrame:-menuCount*80];
        } completion:^(BOOL finished) {
            self.menuViewHidden = NO;
            [self.menuActionDelegate tableMenuDidShowInCell:self];
        }];
    }
    if (x == 50) {
        [UIView animateWithDuration:0.2 animations:^{
            [self initCellFrame:0];
        } completion:^(BOOL finished) {
            self.menuViewHidden = YES;
            [self.menuActionDelegate tableMenuDidHideInCell:self];
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
//    NSString *str = [NSString stringWithUTF8String:object_getClassName(gestureRecognizer)];
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return fabs(translation.x) > fabs(translation.y);
    }
    return YES;
}

- (void)setMenuHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    if (hidden) {
        CGRect frame = self.cellView.frame;
        if (frame.origin.x != 0) {
            [UIView animateWithDuration:0.2 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                self.menuViewHidden = YES;
                [self.menuActionDelegate tableMenuDidHideInCell:self];
                if (completionHandler) {
                    completionHandler();
                }
            }];
        }
    }
}
- (void)setMenuViewHidden:(BOOL)Hidden{
    menuViewHidden = Hidden;
    
    if (Hidden) {
        self.menuView.hidden = YES;
    }else{
        self.menuView.hidden = NO;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (self.menuViewHidden) {
        self.menuView.hidden = YES;
        [super setHighlighted:highlighted animated:animated];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.menuViewHidden) {
        self.menuView.hidden = YES;
        [super setSelected:selected animated:animated];
    }
}

@end
