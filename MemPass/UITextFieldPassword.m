//
//  UITextFieldPassword.m
//  MemPass
//
//  Created by Nikolay Malofeev on 4/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import "UITextFieldPassword.h"

@implementation UITextFieldPassword

#define MAX_LENGTH 6
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    if (self) {
        self.delegate = self;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.location >= MAX_LENGTH)
        return NO;
    else
        return YES;
}

@end
