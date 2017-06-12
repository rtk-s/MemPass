//
//  SqlLoader.m
//  MemPass
//
//  Created by Nikolay Malofeev on 5/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import "SqlLoader.h"
#import "UserData.h"

@implementation SqlLoader
@synthesize db;
NSMutableArray *dataArray;
NSString *pincode;

-(id) init:(NSString *) pinCode{
    self = [super init];
    dataArray = [[NSMutableArray alloc]init];
    pincode = pinCode;
    [self initalizeDatabase];
    return self;
}

#pragma mark Initialize the database
-(void) initalizeDatabase{
    char *err = nil;

    NSArray *data = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *file = [[data objectAtIndex:0] stringByAppendingPathComponent:@"data.sql"];
    NSLog(@"%@", file);
    if(sqlite3_open([file UTF8String], &db) == SQLITE_OK){
        sqlite3_exec(db, "CREATE TABLE users(id INTEGER PRIMARY KEY, type TEXT NOT NULL, username TEXT NOT NULL, password TEXT NOT NULL)", queryCallback, nil, &err);
    }
    if(err){
        printf("%s\n",err);
        err = nil;
    }
}

#pragma mark Add a user to the SQLite database
-(BOOL) addUser: (NSString *)username Password:(NSString *)pass AccountType:(NSString *)type Pin:(NSString *)pin{
    char *err = nil;
    NSString *encryptUser = [AESCrypt encrypt:username password:pin];
    NSString *encryptPass = [AESCrypt encrypt:pass password:pin];
    NSString *query = [NSString stringWithFormat:@"INSERT INTO users(type,username,password) VALUES('%@','%@','%@');",encryptUser,encryptPass,type];
    sqlite3_exec(db,[query UTF8String], queryCallback, nil, &err);
    if(err){
        printf("%s",err);
        return NO;
    }
    else
        return YES;
}

#pragma mark Get all stored encrypted users;
-(NSMutableArray *) getAllUsers{
    [dataArray removeAllObjects];
    char *err = nil;
    sqlite3_exec(db, "SELECT id,username,password FROM users", queryCallback, nil, &err);
    if(err){
        printf("---------\n%s\n",err);
        return nil;
    }else
        return dataArray;
}

#pragma mark Get encrypted user data using user id
-(NSMutableArray *) getUser:(NSInteger)userID{
    [dataArray removeAllObjects];
    char *err = nil;
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM users WHERE id = %li;",(long)userID];
    sqlite3_exec(db,[query UTF8String], queryCallback,nil, &err);
    if(err)
        printf("#########\n%s\n",err);
    return dataArray;
}

#pragma mark Delete a saved username and passeord based on the id
-(void) deleteUser:(NSInteger)userID{
    [dataArray removeAllObjects];
    char *err = nil;
    NSString *query = [NSString stringWithFormat:@"DELETE FROM users WHERE id=%li",userID];
    sqlite3_exec(db, [query UTF8String], queryCallback, nil, &err);
    if(err)
        printf("$$$$$$$$$$\n%s\n",err);
}

#pragma mark Get saved the user count
-(NSInteger) getUserCount:(NSString *) pass{
    [dataArray removeAllObjects];
    char *err = nil;
    sqlite3_exec(db, "SELECT * FROM users;", queryCallback, nil, &err);
    if(err){
        printf("&&&&&&&&&&\n%s\n",err);
        return 0;
    }else{
        int length = 0;
        
        for(int i =0 ; i< [dataArray count]; i++){
            UserData *tempUser = [dataArray objectAtIndex:i];
            if([AESCrypt decrypt:[tempUser getUsername] password:pass] != nil)
                length++;
        }
        return length;
    }
}

#pragma mark C-level callback for the sqlite3 module
int queryCallback(void *a_parm, int argc, char **argv, char **column){
    if(argc == 4){
        if([AESCrypt decrypt:[NSString stringWithUTF8String:argv[1]] password:pincode] == nil)
            return 0;
        printf("%s",argv[0]);
        UserData *tempUser = [[UserData alloc]init];
        NSInteger uidVal = [[NSString stringWithUTF8String:argv[0]] integerValue];
        [tempUser setUid:uidVal];
        [tempUser setUsername:[NSString stringWithUTF8String:argv[1]]];
        [tempUser setPassword:[NSString stringWithUTF8String:argv[2]]];
        [tempUser setAccountType:[NSString stringWithUTF8String:argv[3]]];
        [dataArray addObject:tempUser];
    }
    return 0;
}

@end
