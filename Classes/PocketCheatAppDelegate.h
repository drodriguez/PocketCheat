//
//  PocketCheatAppDelegate.h
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 20/01/09.
//

#import <UIKit/UIKit.h>

@interface PocketCheatAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
