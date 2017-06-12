//
//  NSData+Base64.m
//  Nikolay Malofeev
//
//  Created by Nikolay Malofeev on 06/05/17.
//  Copyright (c) 2017 Nikolay Malofeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Base64Additions)

+ (NSData *)base64DataFromString:(NSString *)string;

@end
