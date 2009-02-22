//
//  PCCheatManager.h
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 22/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PCCheatManager : NSObject {
 @private
  NSArray *allCheats_;
  NSArray *justCreated_;
  NSArray *justUpdated_;
  
  NSMutableDictionary *cheatCache;
}

- (id)initWithDatabase:(NSURL *)databaseURL;

- (NSArray *)allCheats;
- (NSArray *)justCreated;
- (NSArray *)justUpdated;

- (NSString *)cheatNamed:(NSString *)cheatName;

@end
