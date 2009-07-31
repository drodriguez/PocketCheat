//
//  PCNSString+Wrap.h
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 25/01/09.
//

#import <Foundation/Foundation.h>


@interface NSString (Wrap)

- (NSString *)wrap;
- (NSString *)wrapAtWidth:(UInt32)width;

@end
