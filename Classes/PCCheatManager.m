//
//  PCCheatManager.m
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 22/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PCCheatManager.h"
#import "PCCheatListParser.h"
#import "PCCheatParser.h"


@implementation PCCheatManager

- (id)initWithDatabase:(NSURL *)databaseURL {
  if (self = [super init]) {
    // TODO: Open database
  }
  
  return self;
}

#define PC_ALL_CHEATS_URL @"http://cheat.errtheblog.com/ya/"
- (NSArray *)allCheats {
  if (!allCheats_) {
    // TODO: first look in the database?
    
    NSURL *url = [NSURL URLWithString:PC_ALL_CHEATS_URL];
    // FIX: do this so we can warn the interface we are downloading
    NSString *yaml = [NSString stringWithContentsOfURL:url];
    
    PCCheatListParser *parser = [[PCCheatListParser alloc] initWithString:yaml];
    if ([parser parse] >= 0) {
      allCheats_ = [parser.elements retain];
    } else {
      // TODO: error?
    }
    
    [parser release];
  }
  
  return allCheats_;
}

#define PC_RECENT_CHEATS_URL @"http://cheat.errtheblog.com/yr/"
- (NSArray *)justCreated {
  if (!justCreated_) {
    // TODO: first look in the database?
    
    NSURL *url = [NSURL URLWithString:PC_RECENT_CHEATS_URL];
    // FIX: do this so we can warn the interface we are downloading
    NSString *yaml = [NSString stringWithContentsOfURL:url];
    
    PCCheatListParser *parser = [[PCCheatListParser alloc] initWithString:yaml];
    if ([parser parse] >= 0) {
      justCreated_ = [parser.elements retain];
    } else {
      // TODO: error?
    }
    
    [parser release];
  }
  
  return justCreated_;
}

#define PC_UPDATED_CHEATS_URL @"http://feeds.feedburner.com/cheatsheets"
- (NSArray *)justUpdated {
  if (!justUpdated_) {
    // TODO: first look in the database?
    
    NSURL *url = [NSURL URLWithString:PC_UPDATED_CHEATS_URL];
    // FIX: do this so we can warn the interface we are downloading
    NSString *atom = [NSString stringWithContentsOfURL:url];
  }
  
  return justUpdated_;
}

#define PC_CHEAT_TEMPLATE_URL @"http://cheat.errtheblog.com/y/%@"
- (NSString *)cheatNamed:(NSString *)cheatName {
  // TODO: Test the cheat cache dictionary and the database.
  NSString *urlStr = [NSString stringWithFormat:PC_CHEAT_TEMPLATE_URL, cheatName];
  NSURL *url = [NSURL URLWithString:urlStr];
  // FIX: do this so we can warn the interface about downloading progress
  NSString *yaml = [NSString stringWithContentsOfURL:url];
  
  NSString *contents;
  
  PCCheatParser *parser = [[PCCheatParser alloc] initWithString:yaml];
  if ([parser parse] >= 0) {
    contents = parser.contents;
  } else {
    // TODO: error
  }
  [parser release];
  
  return contents;
}

@end
