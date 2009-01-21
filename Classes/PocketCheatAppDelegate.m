//
//  PocketCheatAppDelegate.m
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 20/01/09.
//  Copyright Daniel Rodríguez Troitiño 2009. All rights reserved.
//

#import "PocketCheatAppDelegate.h"
#import "PCListController.h"

#define PC_FAVORITES_TAG 1001
#define PC_RECENTS_TAG   1003

@implementation PocketCheatAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {

  PCListController *favorites = [[PCListController alloc] initWithStyle:UITableViewStylePlain];
  favorites.title = @"Favorites";
  UINavigationController *favoritesNavigation =
    [[UINavigationController alloc] initWithRootViewController:favorites];  
  
  PCListController *all = [[PCListController alloc] initWithStyle:UITableViewStylePlain];
  all.title = @"All";
  UINavigationController *allNavigation =
  [[UINavigationController alloc] initWithRootViewController:all];
  
  PCListController *recent = [[PCListController alloc] initWithStyle:UITableViewStylePlain];
  recent.title = @"Just created";
  UINavigationController *recentNavigation =
    [[UINavigationController alloc] initWithRootViewController:recent];
  
  PCListController *updated = [[PCListController alloc] initWithStyle:UITableViewStylePlain];
  updated.title = @"Just updated";
  UINavigationController *updatedNavigation =
  [[UINavigationController alloc] initWithRootViewController:updated];
  
  tabBarController.viewControllers =
    [NSArray arrayWithObjects:favoritesNavigation,
      allNavigation,
      recentNavigation,
     updatedNavigation,
     nil];
  
  [favorites release];
  [favoritesNavigation release];
  [recent release];
  [recentNavigation release];
  [updated release];
  [updatedNavigation release];
  
  // Add the tab bar controller's current view as a subview of the window
  [window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
  [tabBarController release];
  [window release];
  [super dealloc];
}

@end

