//
//  Photo.m
//  maps
//
//  Created by Www Www on 8/18/17.
//  Copyright © 2017 Michael Tishchenko. All rights reserved.
//

#import "Photo.h"

@interface Photo ()

@property (nonatomic, strong) PHAsset *asset;
@property (atomic, strong) UIImage *thumbnail;

@end

@implementation Photo

- (instancetype)initWithAsset:(PHAsset *)asset
{
	if (self = [super init])
	{
		_asset = asset;
	}
	
	return self;
}

- (void)updateThumbnail:(UIImage *)thumbnail
{
	self.thumbnail = [thumbnail copy];
}

- (CLLocationCoordinate2D)position
{
	return nil != self.asset.location ? self.asset.location.coordinate :
				CLLocationCoordinate2DMake(0, 0);
}

@end
