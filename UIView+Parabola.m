//
//  UIView+Parabola.m
//  DingDangB2B
//
//  Created by 张哲 on 15/12/18.
//  Copyright © 2015年 华晓春. All rights reserved.
//

#import "UIView+Parabola.h"

@implementation UIView (Parabola)

-(void)parabolaToPoint:(CGPoint)point duration:(float)duration{
    CAAnimation *animation = [self pathAnimationQuadCurveToPoint:point duration:duration scaleTo:1] ;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"parabola"];
    self.center = point;
}
-(void)parabolaToPoint:(CGPoint)point duration:(float)duration scaleTo:(float)scale{
    CAAnimation *animation = [self pathAnimationQuadCurveToPoint:point duration:duration scaleTo:scale] ;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"parabola"];
    self.transform =CGAffineTransformMakeScale(scale, scale);
    self.center = point;
}

- (CAAnimation*)pathAnimationQuadCurveToPoint:(CGPoint )pt duration:(float)duration scaleTo:(float)sc;
{
    
    CGPoint orignal =  self.center;
    CGPoint contolPoin = CGPointZero;
    CGPoint symPoint = CGPointZero;
    CGPoint destPoint = pt;
    contolPoin.x =130.0;// orignal.x + (destPoint.x - orignal.x)/2;
    contolPoin.y =60.0;// orignal.y - (destPoint.y - orignal.y);
    
    symPoint.x = 2* contolPoin.x - orignal.x;
    symPoint.y = orignal.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,orignal.x,orignal.y);
    CGPathAddQuadCurveToPoint(path,NULL,contolPoin.x ,contolPoin.y,destPoint.x,destPoint.y);
    CAKeyframeAnimation *
    animation = [CAKeyframeAnimation
                 animationWithKeyPath:@"position"];
    [animation setPath:path];
    [animation setDuration:duration];
    CFRelease(path);
    
    
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue = [NSNumber numberWithFloat:sc];
    scaleAnimation.duration = duration;
    
    
    CAAnimationGroup * animationGp = [CAAnimationGroup animation];
    animationGp.duration = duration;
    animationGp.animations = @[animation,scaleAnimation];
    return animationGp;
}
-(void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"抛物线开始");
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        NSLog(@"抛物线完成");
        [UIView animateWithDuration:0.03
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.alpha = 0.3;
                         }
                         completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    }
}
@end
