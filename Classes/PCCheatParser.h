//
//  PCCheatParser.h
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 21/01/09.
//

#import <Foundation/Foundation.h>


@interface PCCheatParser : NSObject {
  NSString *yaml_;
  NSString *title_;
  NSString *contents_;
}

- (id)initWithString:(NSString *)yaml;

- (int)parse;

@property(nonatomic, readonly, retain) NSString *title;
@property(nonatomic, readonly, retain) NSString *contents;

@end
