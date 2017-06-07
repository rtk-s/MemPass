//
//  ViewController.h
//  MemPass
//
//  Created by Nikolay Malofeev on 4/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextFieldPassword.h"
#define PASSWORD_LENGTH 6

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextFieldPassword *passField;
-(IBAction) submitPassword:(id)sender;
@end

