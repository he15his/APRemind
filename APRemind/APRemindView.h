//
//  APRemindView.h
//  JLnews
//
//  Created by he15his on 13-12-2.
//  Copyright (c) 2013年 he15his. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  正确和错误提醒弹出视图
 */
@interface APRemindView : UILabel

#pragma mark - 显示在window

/**
 *  显示成功提示框在Window上
 *
 *  @param status 提示信息
 */
+ (void)showSuccessWithStatus:(NSString *)status;

/**
 *  显示成功提示框在Window上
 *
 *  @param status 提示信息
 *  @param y      y位置
 */
+ (void)showSuccessWithStatus:(NSString *)status
                       ySpace:(CGFloat)y;

/**
 *  显示错误提示框在Window上
 *
 *  @param status 提示信息
 */
+ (void)showErrorWithStatus:(NSString *)status;

/**
 *  显示错误提示框在Window上
 *
 *  @param status 提示信息
 *  @param y      y位置
 */
+ (void)showErrorWithStatus:(NSString *)status
                     ySpace:(CGFloat)y;

#pragma mark 显示在view
/**
 *  显示成功提示框
 *
 *  @param status 提示信息
 *  @param view   显示的view
 */
+ (void)showSuccessWithStatus:(NSString *)status
                       inView:(UIView *)view;

/**
 *  显示成功提示框在Window上
 *
 *  @param status 提示信息
 *  @param view   显示的view
 *  @param y      y位置
 */
+ (void)showSuccessWithStatus:(NSString *)status
                       inView:(UIView *)view
                       ySpace:(CGFloat)y;

/**
 *  显示错误提示框
 *
 *  @param status 提示信息
 *  @param view   显示的view
 */
+ (void)showErrorWithStatus:(NSString *)status
                     inView:(UIView *)view;

/**
 *  显示错误提示框在Window上
 *
 *  @param status 提示信息
 *  @param view   显示的view
 *  @param y      y位置
 */
+ (void)showErrorWithStatus:(NSString *)status
                     inView:(UIView *)view
                     ySpace:(CGFloat)y;
@end
