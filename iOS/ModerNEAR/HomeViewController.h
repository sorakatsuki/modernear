//
//  HomeViewController.h
//  ModerNEAR
//
//  Created by albcheun on 10/19/13.
//  Copyright (c) 2013 albcheun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController : UIViewController<CLLocationManagerDelegate>

@property(nonatomic,retain) CLLocationManager *locationManager;

@end
