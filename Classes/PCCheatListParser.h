//
//  PCCheatListParser.h
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 21/01/09.
//  Copyright 2009 Daniel Rodríguez Troitiño. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCCheatListParser : NSObject {
 @private
  NSString *yaml_;
  NSString *title_;
  NSArray *elements_;
}

- (id)initWithString:(NSString *)yaml;

- (int)parse;

@property(nonatomic, readonly, retain) NSString *title;
@property(nonatomic, readonly, retain) NSArray *elements;

@end
