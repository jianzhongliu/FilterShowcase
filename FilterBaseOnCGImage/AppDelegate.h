//
//  AppDelegate.h
//  FilterBaseOnCGImage
//
//  Created by jianzhong on 5/9/14.
//  Copyright (c) 2014 ANJUKE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowcaseViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *filterNavigationController;
    ShowcaseViewController *filterListController;
}
@property (strong, nonatomic) UIWindow *window;

@end
