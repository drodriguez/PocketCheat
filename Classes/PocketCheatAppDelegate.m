//
//  PocketCheatAppDelegate.m
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 20/01/09.
//  Copyright Daniel Rodríguez Troitiño 2009. All rights reserved.
//

#import "PocketCheatAppDelegate.h"

#include "yaml.h"

@implementation PocketCheatAppDelegate

@synthesize window;
@synthesize tabBarController;

void dumpNode(yaml_document_t *doc, yaml_node_t *node) {
  yaml_node_pair_t *pair;
  yaml_node_item_t *item;
  yaml_node_t *newNode;
  
  NSLog(@"Node tag: %s", node->tag);
  switch (node->type) {
    case YAML_NO_NODE:
      NSLog(@"Empty node");
      break;
    case YAML_SCALAR_NODE:
      NSLog(@"Scalar node");
      NSLog(@"Value: %s", node->data.scalar.value);
      break;
    case YAML_SEQUENCE_NODE:
      NSLog(@"Sequence node");
      for (item = node->data.sequence.items.start; item < node->data.sequence.items.top; item++) {
        NSLog(@"Sequence node key %d", *item);
        newNode = yaml_document_get_node(doc, *item);
        dumpNode(doc, newNode);
      }
      break;
    case YAML_MAPPING_NODE:
      NSLog(@"Mapping node");
      for (pair = node->data.mapping.pairs.start; pair < node->data.mapping.pairs.top; pair++) {
        NSLog(@"Node key id %d", pair->key);
        newNode = yaml_document_get_node(doc, pair->key);
        dumpNode(doc, newNode);
        NSLog(@"Node value id %d", pair->value);
        newNode = yaml_document_get_node(doc, pair->value);
        dumpNode(doc, newNode);
      }
  }
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
  NSURL *allCheatsUrl = [NSURL URLWithString:@"http://cheat.errtheblog.com/yr/"];
  
  NSString *allCheatsYaml = [NSString stringWithContentsOfURL:allCheatsUrl];
  
  yaml_parser_t parser;
  yaml_document_t document;
  
  int done = 0;
  
  yaml_parser_initialize(&parser);
  yaml_parser_set_input_string(&parser, [allCheatsYaml UTF8String], [allCheatsYaml length]);
  
  while (!done) {
    if (!yaml_parser_load(&parser, &document)) {
      NSLog(@"yaml_parser_load failed!");
      break;
    }
    
    yaml_node_t *node = yaml_document_get_root_node(&document);
    if (!node) {
      NSLog(@"yaml_document_get_root_node returned NULL");
      break;
    } else {
      dumpNode(&document, node);
    }
    
    yaml_document_delete(&document);
  }
  yaml_parser_delete(&parser);  
  
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

