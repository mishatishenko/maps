//
//  Photo.h
//  maps
//
//  Created by Www Www on 8/18/17.
//  Copyright © 2017 Michael Tishchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/PHAsset.h>
#import "GMUMarkerClustering.h"
#import <GoogleMaps/GoogleMaps.h>

@class PHAsset;

@interface Photo : NSObject <GMUClusterItem>

@property (nonatomic, readonly) PHAsset *asset;
@property (atomic, readonly) UIImage *thumbnail;

- (instancetype)initWithAsset:(PHAsset *)asset;
- (void)updateThumbnail:(UIImage *)thumbnail;

@end
