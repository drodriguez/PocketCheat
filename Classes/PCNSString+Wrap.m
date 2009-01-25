//
//  PCNSString+Wrap.m
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 25/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PCNSString+Wrap.h"

UInt32 numberOfStartingSpaces(NSString *str) {
  NSUInteger index = 0;
  NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet];
  
  while (index < [str length]) {
    unichar chr = [str characterAtIndex:index];
    
    if (![whitespace characterIsMember:chr]) {
      break;
    }
    
    index++;
  }
  
  return index;
}


@implementation NSString (Wrap)

- (NSString *)wrap {
  return [self wrapAtWidth:80];
}

- (NSString *)wrapAtWidth:(UInt32)width {
  NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet];

  NSArray *lines = [self componentsSeparatedByString:@"\n"];
  
  NSMutableArray *newLines = [[NSMutableArray alloc] initWithCapacity:[lines count]];
  
  for (NSString *line in lines) {
    UInt32 indent = numberOfStartingSpaces(line);
    NSUInteger length = [line length];
    unichar *chars = malloc(length * sizeof(unichar));
    // TODO: handle errors
    [line getCharacters:chars];
    BOOL first = YES;
    NSUInteger index = 0;
        
    while (index < length) {
      NSUInteger sublineIndent;
      if (first) {
        sublineIndent = 0;
        first = FALSE;
      } else {
        sublineIndent = indent;
      }
      NSUInteger sublineLength = width - sublineIndent;
      
      NSUInteger cutLength = sublineLength;
      if (length-index > sublineLength) {
        while (cutLength > 0 && ![whitespace characterIsMember:chars[index+cutLength]]) {
          cutLength--;
        }
        if (cutLength == 0) cutLength = sublineLength;
      } else {
        cutLength = length - index;
      }
      NSMutableString *buffer = [[NSMutableString alloc] initWithString:@""];
      if (sublineIndent > 0) {
        [buffer appendFormat:@"%.*c", sublineIndent, ' '];
      }
      NSString *subline = [[NSString alloc] initWithCharacters:chars+index length:cutLength];
      [buffer appendString:subline];
      // NSLog(@"Adding <%@>", buffer);
      [newLines addObject:buffer];
      [subline release];
      [buffer release];
      
      index += cutLength;
      while([whitespace characterIsMember:chars[index]] && index < length) {
        index++;
      }
    }
    
    free(chars);
  }
  
  NSString *result = [newLines componentsJoinedByString:@"\n"];
  [newLines release];
  
  return result;
}

@end
