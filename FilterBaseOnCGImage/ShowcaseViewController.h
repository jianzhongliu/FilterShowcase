//
//  ShowcaseViewController.h
//  FilterShowcase
//
//  Created by jianzhong on 4/9/14.
//  Copyright (c) 2014 Cell Phone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowcaseViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController * imagePicker;
    UIPopoverController *_accountBookPopSelectViewController;
}
@property(nonatomic, strong) UIImagePickerController * imagePicker;
@end
