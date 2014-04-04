//
//  OverLayView.h
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-4.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OverLayView;

@protocol OverLayViewDelegate <NSObject>
-(UIView *)overLayView:(OverLayView *)view didHitPoint:(CGPoint)didHitPoint withEvent:(UIEvent *)withEvent;
@end

@interface OverLayView : UIView
@property(nonatomic, assign) id<OverLayViewDelegate> delegate;

@end
