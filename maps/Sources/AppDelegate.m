//
//  AppDelegate.m
//  maps
//
//  Created by Www Www on 7/12/17.
//  Copyright © 2017 Michael Tishchenko. All rights reserved.
//

#import "AppDelegate.h"
@import GoogleMaps;
@import GooglePlaces;

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application
			didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[GMSServices provideAPIKey:@"AIzaSyBzYemGXxfZGcpwLibCv5k-9jjesxDKXh8"];
	[GMSPlacesClient provideAPIKey:@"AIzaSyBzYemGXxfZGcpwLibCv5k-9jjesxDKXh8"];

	return YES;
}

@end
