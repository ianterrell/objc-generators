//
//  Group.h
//  MyApp
//
//  Generated by Ian Terrell on 03/22/2009.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"



@interface Group : SQLitePersistentObject {
  NSString *title;
  NSString *description;
  NSInteger groupId;
}

@property (nonatomic,readwrite,retain) NSString *title;
@property (nonatomic,readwrite,retain) NSString *description;
@property (nonatomic,readwrite) NSInteger groupId;

+(NSString *)helloWorld;

@end
