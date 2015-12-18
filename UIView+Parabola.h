//
//  UIView+Parabola.h
//  DingDangB2B
//
//  Created by 张哲 on 15/12/18.
//  Copyright © 2015年 华晓春. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Parabola)
-(void)parabolaToPoint:(CGPoint)point duration:(float)duration;
-(void)parabolaToPoint:(CGPoint)point duration:(float)duration scaleTo:(float)scale;
@end
