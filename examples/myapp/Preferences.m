//
//  Preferences.m
//  MyApp
//
//  Generated by Ian Terrell on 04/12/2009
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

NSString * _username;
NSString * _password;

+(BOOL)preferencesSet {
  return !(
    (([Preferences username] == nil) || ([[Preferences username] isEqualToString:@""])) || 
    (([Preferences password] == nil) || ([[Preferences password] isEqualToString:@""]))
  );
}

+(void)setUsername:(NSString *)username andPassword:(NSString *)password {
  [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
	_username = username;
  [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
	_password = password;
}

+(NSString *)username {
	if (_username == nil)
		_username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
	return _username;
}
+(NSString *)password {
	if (_password == nil)
		_password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
	return _password;
}

+(NSString *)helloWorld {
      return @"Hello World!";

}

@end
