//
//  AccountInfoViewController.m
//  MemPass
//
//  Created by Nikolay Malofeev on 4/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "UserListsViewController.h"

@interface AccountInfoViewController ()

@end

@implementation AccountInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.AccountType.text = self.account;
    self.username.text = self.uname;
    self.password.text = self.pass;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UserListsViewController *vcSeg = (UserListsViewController *) [segue destinationViewController];
    vcSeg.passwordFromSegue = self.pincode;
}

@end
