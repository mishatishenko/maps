//
//  PhotoStorage.h
//  maps
//
//  Created by Www Www on 8/18/17.
//  Copyright © 2017 Michael Tishchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photo;
@protocol PhotoStorageChangeObserver;

typedef NS_ENUM(NSUInteger, PhotoStorageAccess)
{
	kPhotoStorageAccessAllowed,
	kPhotoStorageAccessDenied,
	kPhotoStorageAccessNotDetermined
};

@interface PhotoStorage : NSObject

@property (nonatomic, readonly) NSArray<Photo *> *photos;
@property (nonatomic, weak) id<PhotoStorageChangeObserver> observer;

- (PhotoStorageAccess)accessStatus;
- (void)requestAccessStatusWithCompletion:(void (^)(PhotoStorageAccess status))completion;
- (void)setupWithCompletion:(void (^)(NSError *))completion;

@end

@protocol PhotoStorageChangeObserver <NSObject>

- (void)photoStorageWasChanged:(PhotoStorage *)sender;

@end
