//
//  Group.m
//  MyApp
//
//  Generated by Ian Terrell on 04/12/2009.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Group.h"
#import "SQLiteInstanceManager.h"

@implementation Group

@synthesize title, description, groupId;

DECLARE_PROPERTIES(
  DECLARE_PROPERTY(@"title", @"@\"NSString\""),
  DECLARE_PROPERTY(@"description", @"@\"NSString\""),
  DECLARE_PROPERTY(@"groupId", @"@\"NSInteger\"")
)

+(NSString *)helloWorld {
      return @"Hello World!";

}

+(void)deleteAll {
	NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@;", [Group tableName]];
  NSLog([NSString stringWithFormat:@"Executing SQL:  DELETE FROM %@;", [Group tableName]]);
  SQLiteInstanceManager *manager = [SQLiteInstanceManager sharedManager];
  [manager executeUpdateSQL:sql];
  [manager vacuum];
  [Group clearCache];
}

- (void)dealloc
{
  [title release];
  [description release];
	[super dealloc];
}

@end
