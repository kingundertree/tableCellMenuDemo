//
//  OverLayView.m
//  TableViewCellMenu
//
//  Created by shan xu on 14-4-4.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "OverLayView.h"

@implementation OverLayView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [self.delegate overLayView:self didHitPoint:point withEvent:event];
}

@end
