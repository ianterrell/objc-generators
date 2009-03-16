//
//  Group.m
//  MyApp
//
//  Generated by Ian Terrell on 03/15/2009.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Group.h"

@implementation Group

@synthesize title, description, groupId;

DECLARE_PROPERTIES(
  DECLARE_PROPERTY(@"title", @"@\"NSString\""),
  DECLARE_PROPERTY(@"description", @"@\"NSString\""),
  DECLARE_PROPERTY(@"groupId", @"@\"NSInteger\"")
)

- (void)dealloc
{
  [title release];
  [description release];
	[super dealloc];
}

@end