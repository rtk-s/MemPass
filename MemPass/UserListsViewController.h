//
//  UserListsViewController.h
//  MemPass
//
//  Created by Nikolay Malofeev on 5/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SqlLoader.h"
#import "UserData.h"

@interface UserListsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) SqlLoader *loader;
@property(nonatomic, strong) NSString *passwordFromSegue;
@property(nonatomic, weak) IBOutlet UITableView *userList;

- (IBAction)btnAdd:(id)sender;
@end
