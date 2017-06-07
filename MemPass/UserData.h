//
//  UserData.h
//  MemPass
//
//  Created by Nikolay Malofeev on 5/05/17.
//  Copyright © 2017 Nikolay Malofeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject{
    NSString *username;
    NSString *password;
    NSString *accountType;
    NSInteger uid;
}

@property(nonatomic) NSString *username;
@property(nonatomic) NSString *password;
@property(nonatomic) NSString *accountType;
@property(nonatomic) NSInteger uid;


-(id) initWithAccount:(NSString *)user Password:(NSString *)pass AccountType:(NSString *)type UserID:(NSInteger)userid;
-(id) init;

//accessor methods
-(NSString *) getUsername;
-(NSString *) getPassword;
-(NSString *) getAccountType;
-(NSInteger) getUID;

//mutator methods.
-(void) setUsername:(NSString *)user;
-(void) setPassword:(NSString *)pass;
-(void) setAccountType:(NSString *)type;
-(void) setUserID:(NSInteger)userid;
@end
