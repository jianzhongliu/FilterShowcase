#import <UIKit/UIKit.h>

@class ShowcaseViewController;

@interface ShowcaseAppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *filterNavigationController;

    ShowcaseViewController *filterListController;
}

@property (strong, nonatomic) UIWindow *window;

@end
