//
//  UserListsViewController.m
//  MemPass
//
//  Created by Nikolay Malofeev on 5/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import "UserListsViewController.h"
#import "AccountInfoViewController.h"
@interface UserListsViewController () <UITableViewDelegate, UITableViewDataSource>

@end
NSMutableArray *arr;
@implementation UserListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userList.dataSource = self;
    self.userList.delegate = self;
    self.loader = [[SqlLoader alloc]init: self.passwordFromSegue];
    arr = [self.loader getAllUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAdd:(id)sender {
    UIAlertController *alert =  [UIAlertController alertControllerWithTitle:@"Add Account" message:@"Enter an Account" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Site";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Username";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES;
    }];
    
   
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *handle){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loader addUser:[[alert textFields][1] text] Password:[[alert textFields][2] text] AccountType:[[alert textFields][0] text] Pin:self.passwordFromSegue];
            [self.userList reloadData];

        });
    }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"infosegue" sender:[arr objectAtIndex:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.loader getUserCount:self.passwordFromSegue];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellRow"];
    }
    UserData *temp = [arr objectAtIndex:indexPath.item];
    
    cell.textLabel.text = [temp getAccountType];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        UserData *tempUser = [arr objectAtIndex:indexPath.item];
        [self.loader deleteUser:[tempUser getUID]];
        [arr removeAllObjects];
        [self.userList reloadData];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AccountInfoViewController *vcSeg = (AccountInfoViewController *)[segue destinationViewController];
    vcSeg.pincode = self.passwordFromSegue;
    
    UserData *temp = (UserData *)sender;
    vcSeg.uname = [AESCrypt decrypt:[temp getUsername] password:self.passwordFromSegue];;
    vcSeg.pass = [AESCrypt decrypt:[temp getPassword] password:self.passwordFromSegue];;
    vcSeg.account = [temp getAccountType];
}
@end
