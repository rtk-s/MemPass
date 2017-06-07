//
//  SqlLoader.h
//  MemPass
//
//  Created by Nikolay Malofeev on 5/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "AESCrypt.h"

@interface SqlLoader : NSObject{
    sqlite3 *db;
}
-(id) init:(NSString *) pinCode;
-(void) initalizeDatabase;
-(BOOL) addUser: (NSString *)username Password:(NSString *)pass AccountType:(NSString *)type Pin:(NSString *)pin;
-(NSMutableArray *) getAllUsers;
-(NSMutableArray *) getUser:(NSInteger)userID;
-(void) deleteUser:(NSInteger) userID;
-(NSInteger) getUserCount:(NSString *) pass;

@property(nonatomic) sqlite3 *db;

@end
