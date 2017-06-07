//
//  ViewController.m
//  MemPass
//
//  Created by Nikolay Malofeev on 4/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import "ViewController.h"
#import "UITextFieldPassword.h"
#import "AESCrypt.h"
#import "SqlLoader.h"
#import "UserListsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark hide the keyboard when the user touches the screen
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.passField resignFirstResponder];
}

#pragma mark check password field to ensure it contains 6 characters and go to the UserListsViewController
- (IBAction)submitPassword:(id)sender {
    if([[self.passField text] length] != PASSWORD_LENGTH){
        UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"Error" message:@"Password must be 6 characters long." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *handle){
            [alert dismissViewControllerAnimated:YES completion:NULL];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:NULL];
    }else{
        [self performSegueWithIdentifier:@"homeSegue" sender:sender];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UserListsViewController *vcSeg = [segue destinationViewController];
    vcSeg.passwordFromSegue = [self.passField text];
}
         
@end
