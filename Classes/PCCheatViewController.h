//
//  PCCheatViewController.h
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 25/01/09.
//  Copyright 2009 Daniel Rodríguez Troitiño. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCCheatManager;

@interface PCCheatViewController : UIViewController {
 @private
  PCCheatManager *manager_;
  
  NSString *cheatName_;

 @protected
  IBOutlet UIWebView *webView;
}

@property(nonatomic, assign) PCCheatManager *manager;
@property(nonatomic, copy) NSString *cheatName;

@end
