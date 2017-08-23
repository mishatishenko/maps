//
//  GoogleMapViewController.m
//  maps
//
//  Created by Www Www on 8/18/17.
//  Copyright © 2017 Michael Tishchenko. All rights reserved.
//

#import "GoogleMapViewController.h"
#import "GMUClusterManager.h"
@import GoogleMaps;
#import "PhotoStorage.h"
#import "Photo.h"

@interface GoogleMapViewController ()

@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) GMUClusterManager *clusterManager;
@property (nonatomic, strong) NSArray *photos;

@end

@implementation GoogleMapViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.photos = [NSArray arrayWithArray:self.photoStorage.photos];
	
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
				longitude:151.20 zoom:1];
	GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];

	self.view = mapView;
	self.mapView = mapView;
	
	// Set up the cluster manager with a supplied icon generator and renderer.
	id<GMUClusterAlgorithm> algorithm =
					[GMUNonHierarchicalDistanceBasedAlgorithm new];
	id<GMUClusterIconGenerator> iconGenerator =
					[[GMUDefaultClusterIconGenerator alloc] init];
	id<GMUClusterRenderer> renderer = [[GMUDefaultClusterRenderer alloc]
				initWithMapView:self.mapView clusterIconGenerator:iconGenerator];
	self.clusterManager = [[GMUClusterManager alloc] initWithMap:self.mapView
					algorithm:algorithm renderer:renderer];
}

- (void)reload
{
	[self.clusterManager clearItems];
	self.photos = [NSArray arrayWithArray:self.photoStorage.photos];
	
	for (Photo *photo in self.photos)
	{
		if (nil != photo.asset.location)
		{
			NSLog(@"photo");
			[self.clusterManager addItem:photo];
//			marker.icon = photo.thumbnail;
		}
	}
	
	 [self.clusterManager cluster];
}

@end
