//
//  ViewController.m
//  maps
//
//  Created by Www Www on 7/12/17.
//  Copyright © 2017 Michael Tishchenko. All rights reserved.
//

#import "MapViewController.h"
#import "PhotoStorage.h"
#import "Photo.h"

@interface MapViewController () <PhotoStorageChangeObserver>

@property (nonatomic, strong) PhotoStorage *photoStorage;

@end

@implementation MapViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.photoStorage = [PhotoStorage new];
	self.photoStorage.observer = self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[self.photoStorage setupWithCompletion:^(NSError *error)
	{
		if (nil == error)
		{
			[self reload];
		}
		else
		{
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
						message:@"Please enable access to photos for application"
						preferredStyle:UIAlertControllerStyleAlert];
			[alert addAction:[UIAlertAction actionWithTitle:@"Ok"
						style:UIAlertActionStyleDefault handler:nil]];
			[self presentViewController:alert animated:YES completion:nil];
		}
	}];
}

- (void)reload
{
	
}

#pragma mark - photos observing
- (void)photoStorageWasChanged:(PhotoStorage *)sender
{
	[self reload];
}

@end
