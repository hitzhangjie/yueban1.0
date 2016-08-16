//
//  YBTabBarController.m
//  YueBan
//
//  Created by etund on 16/8/10.
//  Copyright © 2016年 etund. All rights reserved.
//

#import "YBTabBarController.h"

@interface YBTabBarController ()

@end

@implementation YBTabBarController

static Class _navClass;
static Class _tabBarClass;

+ (void)setNavClass:(Class)class{
    _navClass = class;
}

+ (void)setTabBar:(Class)class{
    _tabBarClass = class;
}

#pragma mark - 初始化方法
+ (instancetype)tabBarControllerWithTitleArray:(NSArray *)titles andNormalImages:(NSArray *)nomalImages andSelectedImages:(NSArray *)selectedImages andClassName:(NSArray *)classNames{
    YBTabBarController *tabBarVC = [[YBTabBarController alloc] init];
    NSString * title = nil;
    NSString * nomalImage = nil;
    NSString * selectedImage = nil;
    __unsafe_unretained Class  className = nil;
    for (int i = 0; i < titles.count; i++) {
        title = titles[i];
        nomalImage = nomalImages[i];
        selectedImage = selectedImages[i];
        className = classNames[i];
        [tabBarVC addSigleControllerWith:className andTitle:title withNormalImage:nomalImage andSelectImage:selectedImage];
    }
    [tabBarVC setValue:_tabBarClass == nil?tabBarVC.tabBar:[[_tabBarClass alloc] init] forKeyPath:@"tabBar"];
    return tabBarVC;
}

+ (instancetype)tabBarControllerWithTitleArray:(NSArray *)titles andNormalImages:(NSArray *)nomalImages andSelectedImages:(NSArray *)selectedImages andClassName:(NSArray *)classNames withNavigation:(Class)navigationClass{
    [self setNavClass:navigationClass];
    return [YBTabBarController tabBarControllerWithTitleArray:titles andNormalImages:nomalImages andSelectedImages:selectedImages andClassName:classNames];
}

+ (instancetype)tabBarControllerWithTitleArray:(NSArray *)titles andNormalImages:(NSArray *)nomalImages andSelectedImages:(NSArray *)selectedImages andClassName:(NSArray *)classNames withNavigation:(Class)navigationClass andSelfTabBarClass:(Class)tabBarClass{
    [self setNavClass:navigationClass];
    [self setTabBar:tabBarClass];
    return [YBTabBarController tabBarControllerWithTitleArray:titles andNormalImages:nomalImages andSelectedImages:selectedImages andClassName:classNames];
}


#pragma mark - 添加控制器
//添加单个子控制器
- (void)addSigleControllerWith:(Class)class andTitle:(NSString *)tabBarTitle withNormalImage:(NSString *)imageName andSelectImage:(NSString *)selectImageName{
    UIViewController *vc = [[class alloc] init];
    vc.tabBarItem.title = tabBarTitle;
    [vc.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    if (_navClass == nil && ![_navClass isSubclassOfClass:[UINavigationController class]]) [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:vc]];
    [self addChildViewController:[[_navClass alloc] initWithRootViewController:vc]];
}



@end
