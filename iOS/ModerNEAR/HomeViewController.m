//
//  HomeViewController.m
//  ModerNEAR
//
//  Created by albcheun on 10/19/13.
//  Copyright (c) 2013 albcheun. All rights reserved.
//

#import "HomeViewController.h"
#import "Foursquare2.h"
#import "FSVenue.h"
#import "FSConverter.h"
#import <GoogleMaps/GoogleMaps.h>

@interface HomeViewController ()
    @property (strong, nonatomic) NSArray *nearbyVenues;
@end

@implementation HomeViewController {
    GMSMapView *mapView_;
}

- (NSString *)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", _locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude];
    return theLocation;}

- (void)proccessAnnotations {
    
    for (FSVenue* venue in self.nearbyVenues) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(venue.location.coordinate.latitude, venue.location.coordinate.longitude);
        marker.title = venue.name;
        
        if([venue.name isEqualToString: @"92 Golden Gate Transit"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Uncategorized in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"10 Golden Gate Transit"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Uncategorized in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Marin County Line"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Tourist Information Center in A ZzS", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Vista Point"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Scenic Lookout and Trail in Sausalito", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Golden Gate Bridge Toll Plaza"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - General Travel in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Fort Point National Historic Site"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Historic Site, Park, and Lighthouse in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Hendrik Point"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Scenic Lookout and Park in Marin Headlands", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Digital Photo Academy"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Miscellaneous Shop in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Fort Baker"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Park and Monument / Landmark in Sausalito", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Plaza Park Square"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Uncategorized in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Golden Gate Bridge Pavilion"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Gift Shop, Snack Place, and Historic Site in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Bay Area Discovery Museum"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Museum, General Entertainment, and Playground in Sausalito", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Hopper's Hands"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Other Great Outdoors and Bridge in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"*CLOSED* Golden Gate Bridge Walking Tour"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Tourist Information Center in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"playland Sausalito"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Playground in Sausalito", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Battery Spencer"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Scenic Lookout in Southwest Marin", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Bridge Cafe"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Snack Place and Café in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Fort Point Lighthouse"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Historic Site in San Francisco", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"Kirby Cove"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Scenic Lookout, Campground, and Beach in Sausalito", venue.location.address, venue.location.distance];
        } else if([venue.name isEqualToString: @"*CLOSED* Golden Gate Bridge Photo Experience"]){
            marker.snippet = [NSString stringWithFormat: @"%@ - %@m - Tourist Information Center in San Francisco", venue.location.address, venue.location.distance];
        } else {
            marker.snippet = venue.location.address;
        }
        marker.map = mapView_;
    }
    
}

- (void)getVenuesForLocation:(CLLocation *)location {
    
    [Foursquare2 venueSearchNearByLatitude:@(37.8197722)
                                 longitude:@(-122.478600)
                                     query:nil
                                     limit:nil
                                    intent:intentCheckin
                                    radius:@(2000)
                                categoryId:nil
                                  callback:^(BOOL success, id result){
                                      if (success) {
                                          NSDictionary *dic = result;
                                          NSArray *venues = [dic valueForKeyPath:@"response.venues"];
                                          FSConverter *converter = [[FSConverter alloc]init];
                                          self.nearbyVenues = [converter convertToObjects:venues];
                                          [self proccessAnnotations];
                                          
                                      }
                                  }];
}
// You don't need to modify the default initWithNibName:bundle: method.

- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    // locationManager update as location
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    [_locationManager startUpdatingLocation];
    CLLocation *location = [_locationManager location];
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    
    //Debug Code
    float longitude=coordinate.longitude;
    float latitude=coordinate.latitude;
    NSLog(@"dLongitude : %f",longitude);
    NSLog(@"dLatitude : %f", latitude);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.8197722
                                                            longitude:-122.478600
                                                                 zoom:17];
    

    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    //GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    //marker.title = @"Sydney";
    //marker.snippet = @"Australia";
    //marker.map = mapView_;
    [self getVenuesForLocation:location];
}

@end
