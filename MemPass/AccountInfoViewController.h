//
//  AccountInfoViewController.h
//  MemPass
//
//  Created by Nikolay Malofeev on 4/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import "ViewController.h"

@interface AccountInfoViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *AccountType;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *password;

@property (nonatomic) NSString *account;
@property (nonatomic) NSString *uname;
@property (nonatomic) NSString *pass;
@property (nonatomic) NSString *pincode;

@end
