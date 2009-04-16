//
//  User.m
//  FrankApp
//
//  Generated by Ian Terrell on 04/16/2009.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "User.h"
#import "Frank.h"

@implementation User

@synthesize username, password, awesomenessCode;


#pragma mark Create and Update

+(NSString *)tableName {
  return @"users";
}

-(BOOL)save {
  NSString *sql = nil;
  if ([self isNewRecord])
    sql = @"INSERT INTO users (username, password, awesomeness_code) VALUES (?, ?, ?);";
  else
    sql = [NSString stringWithFormat:@"UPDATE users SET username = ?, password = ?, awesomeness_code = ? WHERE pk = %d;", [pk intValue]];

  FMDatabase *db = [Frank sharedDatabase];
  BOOL success = [db executeUpdate:sql, username, password, awesomenessCode];
  if (success)
    self.pk = [FrankObject lastInsertRowId];
  return success;
}

#pragma mark Helper Methods


+(id)buildFromResultSetRow:(FMResultSet *)rs {
  User *user = [User alloc];
  user.pk = [NSNumber numberWithInt:[rs intForColumn:@"pk"]];
  user.username = [rs stringForColumn:@"username"];
  user.password = [rs stringForColumn:@"password"];
  user.awesomenessCode = [NSNumber numberWithInt:[rs intForColumn:@"awesomeness_code"]];
  return [user autorelease];
}

#pragma mark Boilerplate

- (void)dealloc
{
  [username release];
  [password release];
  [awesomenessCode release];
	[super dealloc];
}

@end