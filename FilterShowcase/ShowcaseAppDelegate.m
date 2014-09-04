#import "ShowcaseAppDelegate.h"
#import "ShowcaseViewController.h"

@implementation ShowcaseAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    filterNavigationController = [[UINavigationController alloc] init];
    [self.window addSubview:filterNavigationController.view];

    filterListController = [[ShowcaseViewController alloc] initWithNibName:nil bundle:nil];
    
    [filterNavigationController pushViewController:filterListController animated:NO];

    [self.window makeKeyAndVisible];
    return YES;
}

@end
