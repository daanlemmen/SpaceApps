//
//  MainViewController.m
//  ISS App
//
//  Created by Daan Lemmen on 20-04-13.
//  Copyright (c) 2013 Daan Lemmen. All rights reserved.
//

#import "MainViewController.h"

@interface NSAnnotation : NSObject <MKAnnotation>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end
@implementation NSAnnotation

@end
@interface MainViewController ()
@property (nonatomic, strong) API *api;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.api = [[API alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", [self.mapView subviews]);
    for (UIView *view in [self.mapView subviews]) {
        if ([[view class] isSubclassOfClass:NSClassFromString(@"MKAttributionLabel")]){
            [view removeFromSuperview];
        }
    }
    self.mapView.layer.masksToBounds = YES;
    self.mapView.layer.cornerRadius = 5.0f;
    [self updateLocations];
    // http://iphone-streaming.ustream.tv/uhls/9408562/streams/live/iphone/playlist.m3u8?appType=11&appVersion=2
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)open:(id)sender {
    MPMoviePlayerViewController *playerViewC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://iphone-streaming.ustream.tv/uhls/9408562/streams/live/iphone/playlist.m3u8?appType=11&appVersion=2"]];
    [self presentMoviePlayerViewControllerAnimated:playerViewC];
}
- (void)updateLocations {
    [self.api issInfo:^(ISSInfo *issInfo) {
        BOOL first = (self.mapView.annotations.count == 0);
        [self.mapView removeAnnotations:self.mapView.annotations];
        NSAnnotation *annotation = [[NSAnnotation alloc] init];
        annotation.title = @"International Space Station";
        annotation.subtitle = [NSString stringWithFormat:@"%.f km/h, %.f km, %@", [issInfo.velocity floatValue], [issInfo.altitude floatValue], issInfo.visibility];
        annotation.coordinate = CLLocationCoordinate2DMake([issInfo.latitude doubleValue], [issInfo.longitude doubleValue]);
        [self zoomToAnnotation:annotation];
        [self.mapView setDelegate:self];
        [self.mapView addAnnotation:annotation];
        [self.mapView selectAnnotation:annotation animated:first];
        [self performSelector:@selector(updateLocations) withObject:nil afterDelay:1];
    } error:^(NSError *error) {
        DLog(@"Error: %@", error.localizedDescription);
    }];
}
- (void)zoomToAnnotation:(NSAnnotation *)annotation {
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 8000000, 8000000);
    
    [self.mapView setRegion:region animated:YES];
    
    [self.mapView reloadInputViews];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    /*
	MKPinAnnotationView *annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([MKPinAnnotationView class])];
    annView.canShowCallout = YES;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(selectedAnnotation:) forControlEvents:UIControlEventTouchUpInside];
    [annView setRightCalloutAccessoryView:rightButton];
    [annView setRightCalloutAccessoryView:nil];
    [annView setImage:[UIImage imageNamed:@"spacestation_icon.png"]];
    return annView;
     */
    MKAnnotationView *annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NSStringFromClass([MKAnnotationView class])];
    annView.canShowCallout = YES;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(selectedAnnotation:) forControlEvents:UIControlEventTouchUpInside];
    [annView setRightCalloutAccessoryView:rightButton];
    [annView setRightCalloutAccessoryView:nil];
    [annView setImage:[UIImage imageNamed:@"spacestation_icon"]];
    return annView;
}
- (void)selectedAnnotation:(id)sender {
    NSLog(@"%@", [[sender superview] subviews]);
    MKPinAnnotationView *annView = (MKPinAnnotationView *)[[sender superview] superview];
    NSAnnotation *annotation = [annView annotation];
    [self.mapView deselectAnnotation:annotation animated:YES];
}
@end
