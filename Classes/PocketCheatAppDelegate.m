//
//  PocketCheatAppDelegate.m
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 20/01/09.
//  Copyright Daniel Rodríguez Troitiño 2009. All rights reserved.
//

#import "PocketCheatAppDelegate.h"
#import "PCCheatListParser.h"

@implementation PocketCheatAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  NSURL *allCheatsUrl = [NSURL URLWithString:@"http://cheat.errtheblog.com/yr/"];
  
  NSString *allCheatsYaml = [NSString stringWithContentsOfURL:allCheatsUrl];
  
  PCCheatListParser *parser = [[PCCheatListParser alloc] initWithString:allCheatsYaml];
  if ([parser parse] < 0) {
    NSLog(@"Parsing failed");
  } else {
    NSArray *results = parser.elements;
    NSLog(@"title: %@", parser.title);
    for (NSString *item in results) {
      NSLog(@"- item: %@", item);
    }
  }
  
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

