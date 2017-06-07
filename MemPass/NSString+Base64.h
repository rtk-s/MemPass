//
//  NSString+Base64.h
//  Nikolay Malofeev
//
//  Created by Nikolay Malofeev on 06/05/17.
//  Copyright (c) 2012 Nikolay Malofeev. All rights reserved.
//

#import <Foundation/NSString.h>

@interface NSString (Base64Additions)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;

@end
