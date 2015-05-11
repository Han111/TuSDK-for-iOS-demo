//
//  SimpleEditAndCutComponent.m
//  TuSDKDemo
//
//  Created by Clear Hu on 15/4/24.
//  Copyright (c) 2015年 Lasque. All rights reserved.
//

#import "SimpleEditAndCutComponent.h"
/**
 *  图片编辑组件 (裁剪)范例
 */
@interface SimpleEditAndCutComponent()<TuSDKPFEditTurnAndCutDelegate>
{
    // 自定义系统相册组件
    TuSDKCPAlbumComponent *_albumComponent;
}
@end

@implementation SimpleEditAndCutComponent
- (instancetype)init;
{
    self = [super initWithGroupId:2 title:NSLocalizedString(@"simple_EditAndCutComponent", @"图片编辑组件 (裁剪)")];
    return self;
}

/**
 *  显示范例
 *
 *  @param controller 启动控制器
 */
- (void)showSimpleWithController:(UIViewController *)controller;
{
    if (!controller) return;
    self.controller = controller;
    
    _albumComponent =
    [TuSDK albumCommponentWithController:controller
                           callbackBlock:^(TuSDKResult *result, NSError *error, UIViewController *controller)
     {
         // 获取头像图片
         if (error) {
             lsqLError(@"album reader error: %@", error.userInfo);
             return;
         }
         [self openEditAndCutWithController:controller result:result];
     }];
    
    [_albumComponent showComponent];
}

/**
 *  开启图片编辑组件 (裁剪)
 *
 *  @param controller 来源控制器
 *  @param result     处理结果
 */
- (void)openEditAndCutWithController:(UIViewController *)controller
                              result:(TuSDKResult *)result;
{
    if (!controller || !result) return;
    
    // 组件选项配置
    // @see-http://tusdk.com/docs/ios/api/Classes/TuSDKPFEditTurnAndCutOptions.html
    TuSDKPFEditTurnAndCutOptions *opt = [TuSDKPFEditTurnAndCutOptions build];
    
    // 是否开启滤镜支持 (默认: 关闭)
    opt.enableFilters = YES;
    
    // 需要裁剪的长宽
    opt.cutSize = CGSizeMake(640, 640);
    
    // 是否显示处理结果预览图 (默认：关闭，调试时可以开启)
    opt.showResultPreview = YES;
    
    // 保存到系统相册 (默认不保存, 当设置为YES时, TuSDKResult.asset)
    // opt.saveToAlbum = YES;
    
    // 保存到系统相册的相册名称
    // opt.saveToAlbumName = @"TuSdk";
    
    TuSDKPFEditTurnAndCutViewController *tcController = opt.viewController;
    // 添加委托
    tcController.delegate = self;
    
    // 处理图片对象 (处理优先级: inputImage > inputTempFilePath > inputAsset)
    tcController.inputImage = result.image;
    tcController.inputTempFilePath = result.imagePath;
    tcController.inputAsset = result.imageAsset;
    
    [controller.navigationController pushViewController:tcController animated:YES];
}

/**
 *  图片编辑完成
 *
 *  @param controller 旋转和裁剪视图控制器
 *  @param result 旋转和裁剪视图控制器处理结果
 */
- (void)onTuSDKPFEditTurnAndCut:(TuSDKPFEditTurnAndCutViewController *)controller result:(TuSDKResult *)result;
{
    _albumComponent = nil;
    
    // 清除所有控件
    [controller dismissModalViewControllerAnimated];
    lsqLDebug(@"onTuSDKPFEditTurnAndCut: %@", result);
}

/**
 *  获取组件返回错误信息
 *
 *  @param controller 控制器
 *  @param result     返回结果
 *  @param error      异常信息
 */
- (void)onComponent:(TuSDKCPViewController *)controller result:(TuSDKResult *)result error:(NSError *)error;
{
    lsqLDebug(@"onComponent: controller - %@, result - %@, error - %@", controller, result, error);
}
@end