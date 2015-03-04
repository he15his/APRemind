//
//  APRemindView.m
//  JLnews
//
//  Created by he15his on 13-12-2.
//  Copyright (c) 2013年 he15his. All rights reserved.
//

#import "APRemindView.h"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define RGBColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

@interface NSString(Size)

/**
 *  计算文本大小方法
 *
 *  @param font 字体
 *  @param mode 换行方式
 *  @param size 尺寸范围
 *
 *  @return 返回文本显示的Size
 */
- (CGSize)textSizeWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)mode boundingSize:(CGSize)size;
@end

@implementation NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)mode boundingSize:(CGSize)size
{
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = mode;
        paragraphStyle.maximumLineHeight = 30.0;
        paragraphStyle.minimumLineHeight = 16.0;
        
        NSDictionary *attributes = @{ NSFontAttributeName: font,
                                      NSParagraphStyleAttributeName: paragraphStyle};
        
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else
    {
        return [self sizeWithFont:font constrainedToSize:size lineBreakMode:(NSLineBreakMode)mode];
    }
}
@end

@interface APRemindView()
{
    NSTimer *_timer;
}
@end

@implementation APRemindView

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, kDeviceWidth, 30);
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:248/255.0 green:18/255.0 blue:18/255.0 alpha:0.75];
        self.textColor = [UIColor whiteColor];
        self.numberOfLines = 0;
        self.alpha = 0;
        self.font = [UIFont systemFontOfSize:12];
        self.textAlignment = NSTextAlignmentCenter;
        self.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return self;
}

+ (APRemindView *)share
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)showSuccessWithStatus:(NSString *)status{
    
    [self share].backgroundColor = RGBColor(205, 214, 221);
    [self share].textColor = RGBColor(70, 81, 103);
    [[self share] showString:status inView:nil ySpace:0];
}

+ (void)showSuccessWithStatus:(NSString *)status
                       ySpace:(CGFloat)y{
    
    [self share].backgroundColor = RGBColor(205, 214, 221);
    [self share].textColor = RGBColor(70, 81, 103);
    [[self share] showString:status inView:nil ySpace:y];
}

+ (void)showErrorWithStatus:(NSString *)status{
    
    [self share].backgroundColor = [UIColor colorWithRed:248/255.0 green:18/255.0 blue:18/255.0 alpha:0.75];
    [self share].textColor = [UIColor whiteColor];
    [[self share] showString:status inView:nil ySpace:0];
}

+ (void)showErrorWithStatus:(NSString *)status
                     ySpace:(CGFloat)y{
    
    [self share].backgroundColor = [UIColor colorWithRed:248/255.0 green:18/255.0 blue:18/255.0 alpha:0.75];
    [self share].textColor = [UIColor whiteColor];
    [[self share] showString:status inView:nil ySpace:y];
}

+ (void)showSuccessWithStatus:(NSString *)status
                       inView:(UIView *)view{
    
    [self share].backgroundColor = RGBColor(205, 214, 221);
    [self share].textColor = RGBColor(70, 81, 103);
    [[self share] showString:status inView:view ySpace:0];
}

+ (void)showSuccessWithStatus:(NSString *)status
                       inView:(UIView *)view
                       ySpace:(CGFloat)y{
    
    [self share].backgroundColor = RGBColor(205, 214, 221);
    [self share].textColor = RGBColor(70, 81, 103);
    [[self share] showString:status inView:view ySpace:y];
}

+ (void)showErrorWithStatus:(NSString *)status
                     inView:(UIView *)view{
    
    [self share].backgroundColor = [UIColor colorWithRed:248/255.0 green:18/255.0 blue:18/255.0 alpha:0.75];
    [self share].textColor = [UIColor whiteColor];
    [[self share] showString:status inView:view ySpace:0];
}

+ (void)showErrorWithStatus:(NSString *)status
                     inView:(UIView *)view
                     ySpace:(CGFloat)y{
    
    [self share].backgroundColor = [UIColor colorWithRed:248/255.0 green:18/255.0 blue:18/255.0 alpha:0.75];
    [self share].textColor = [UIColor whiteColor];
    [[self share] showString:status inView:view ySpace:y];
}

- (void)showString:(NSString *)string
            inView:(UIView *)view
            ySpace:(CGFloat)y
{
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
        if (self.superview)
        {
            [_timer invalidate];
            self.alpha = 0.0;
        }
    } completion:^(BOOL finished){
        if (finished) {
            if (self.superview) {
                [self removeFromSuperview];
            }
            
            self.text = string;
            CGSize size = [string textSizeWithFont:self.font lineBreakMode:self.lineBreakMode boundingSize:CGSizeMake(kDeviceWidth-20, 200)];
            size.width = kDeviceWidth;
            
            if (size.height < 30) {
                size.height = 30;
            }
            CGRect frame = self.frame;
            frame.size = size;
            frame.origin.y = y;
            self.frame = frame;
            
            if (!view) {
                NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
                
                for (UIWindow *window in frontToBackWindows)
                    if (window.windowLevel == UIWindowLevelNormal) {
                        [window addSubview:self];
                        break;
                    }
            }else{
                [view addSubview:self];
            }
            
            
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha = 1;
            } completion:^(BOOL finished) {
                
                _timer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
            }];
        }
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 10, 0, 10))];
}

@end