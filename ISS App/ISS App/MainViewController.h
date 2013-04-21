//
//  MainViewController.h
//  ISS App
//
//  Created by Daan Lemmen on 20-04-13.
//  Copyright (c) 2013 Daan Lemmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "API.h"
#import <MediaPlayer/MediaPlayer.h>
@interface MainViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
- (IBAction)open:(id)sender;
@end
