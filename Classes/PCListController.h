//
//  PCListController.h
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 21/01/09.
//

#import <UIKit/UIKit.h>

@class PCCheatManager;

@interface PCListController : UITableViewController {
 @private
  PCCheatManager *manager_;
  SEL elementsSelector_;
  NSArray *elements_;
}

- (id)initWithManager:(PCCheatManager *)manager andElements:(SEL)elementsSelector;

@end
