//
//  AppDelegate.m
//  WeChat Work
//
//  Created by 卫宫巨侠欧尼酱 on 2021/2/23.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    
    [SMJADmanager.share initWithUMAppkey:@"603895e06ee47d382b677f31"
                      rootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"nav"]
                    showSplashAdComplete:^{
        if (SMJADmanager.share.isOpenLongImage &&
            !SMJADmanager.share.isEverLaunched) {
            self.window.rootViewController = SMJADNavigationController.rootViewController;
        }
    }];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [SMJADmanager.share showVideoAdWhenFromBackgroundBecomeForeground];
}

@end
