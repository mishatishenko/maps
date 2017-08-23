//
//  ClusterRenderer.m
//  maps
//
//  Created by Www Www on 8/22/17.
//  Copyright © 2017 Michael Tishchenko. All rights reserved.
//

#import "ClusterRenderer.h"

#import "GMUDefaultClusterRenderer+Testing.h"

#import <GoogleMaps/GoogleMaps.h>

#import "GMUClusterIconGenerator.h"
#import "GMUWrappingDictionaryKey.h"

@implementation ClusterRenderer

- (void)renderCluster:(id<GMUCluster>)cluster animated:(BOOL)animated {
  float zoom = _mapView.camera.zoom;
  if ([self shouldRenderAsCluster:cluster atZoom:zoom]) {
    CLLocationCoordinate2D fromPosition = kCLLocationCoordinate2DInvalid;
    if (animated) {
      id<GMUCluster> fromCluster =
          [self overlappingClusterForCluster:cluster itemMap:_itemToOldClusterMap];
      animated = fromCluster != nil;
      fromPosition = fromCluster.position;
    }

    UIImage *icon = [_clusterIconGenerator iconForSize:cluster.count];
    GMSMarker *marker = [self markerWithPosition:cluster.position
                                            from:fromPosition
                                        userData:cluster
                                     clusterIcon:icon
                                        animated:animated];
    [_markers addObject:marker];
  } else {
    for (id<GMUClusterItem> item in cluster.items) {
      CLLocationCoordinate2D fromPosition = kCLLocationCoordinate2DInvalid;
      BOOL shouldAnimate = animated;
      if (shouldAnimate) {
        GMUWrappingDictionaryKey *key = [[GMUWrappingDictionaryKey alloc] initWithObject:item];
        id<GMUCluster> fromCluster = [_itemToOldClusterMap objectForKey:key];
        shouldAnimate = fromCluster != nil;
        fromPosition = fromCluster.position;
      }

      GMSMarker *marker = [self markerWithPosition:item.position
                                              from:fromPosition
                                          userData:item
                                       clusterIcon:nil
                                          animated:shouldAnimate];
      [_markers addObject:marker];
      [_renderedClusterItems addObject:item];
    }
  }
  [_renderedClusters addObject:cluster];
}

// Returns a marker at final position of |position| with attached |userData|.
// If animated is YES, animates from the closest point from |points|.
- (GMSMarker *)markerWithPosition:(CLLocationCoordinate2D)position
                             from:(CLLocationCoordinate2D)from
                         userData:(id)userData
                      clusterIcon:(UIImage *)clusterIcon
                         animated:(BOOL)animated {
  GMSMarker *marker = [self markerForObject:userData];
  CLLocationCoordinate2D initialPosition = animated ? from : position;
  marker.position = initialPosition;
  marker.userData = userData;
  if (clusterIcon != nil) {
    marker.icon = clusterIcon;
    marker.groundAnchor = CGPointMake(0.5, 0.5);
  }
  marker.zIndex = _zIndex;

  if ([_delegate respondsToSelector:@selector(renderer:willRenderMarker:)]) {
    [_delegate renderer:self willRenderMarker:marker];
  }
  marker.map = _mapView;

  if (animated) {
    [CATransaction begin];
    [CATransaction setAnimationDuration:kGMUAnimationDuration];
    marker.layer.latitude = position.latitude;
    marker.layer.longitude = position.longitude;
    [CATransaction commit];
  }

  if ([_delegate respondsToSelector:@selector(renderer:didRenderMarker:)]) {
    [_delegate renderer:self didRenderMarker:marker];
  }
  return marker;
}

@end

