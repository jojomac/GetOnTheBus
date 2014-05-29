//
//  ViewController.m
//  GetOnThebus
//
//  Created by Joanne McNamee on 5/28/14.
//  Copyright (c) 2014 JMWHS. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "DetailViewController.h"
#import "MKCustomAnnotation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSString *currentTitle;
@property NSString *currentTransfers;
@property NSString *currentRoutes;
@property NSString *currentAddress;


@property NSArray *stopsArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]

        completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        self.stopsArray = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError]objectForKey:@"row"];

        for (NSDictionary *item in self.stopsArray)
        {
            MKCustomAnnotation *stop = [[MKCustomAnnotation alloc] init];
            stop.title = [item objectForKey:@"cta_stop_name"];
            stop.subtitle = [item objectForKey:@"routes"];
            stop.address = [item objectForKey:@"_address"];
            stop.transfers = [item objectForKey:@"inter_modal"];


            stop.coordinate = CLLocationCoordinate2DMake([[item objectForKey:@"latitude"]floatValue],[[item objectForKey:@"longitude"]floatValue]);
            [self.mapView addAnnotation:stop];

        }

        CLLocationCoordinate2D central = CLLocationCoordinate2DMake(41.89373984, -87.63532979);
        MKCoordinateSpan span = MKCoordinateSpanMake(.4, .4);
        MKCoordinateRegion region = MKCoordinateRegionMake(central, span);
        [self.mapView setRegion:region animated:YES];

    }];
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];

    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:       UIButtonTypeDetailDisclosure];

    return pin;
}
-(void)mapView: (MKMapView *)mapview annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MKCustomAnnotation *selected = (MKCustomAnnotation *)view.annotation;
    self.currentTitle = selected.title;
    self.currentRoutes = selected.subtitle;
    self.currentTransfers = selected.transfers;
    self.currentAddress = selected.address;
   
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];

    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *nextController = [segue destinationViewController];
    nextController.title = self.currentTitle;
    nextController.address = self.currentAddress;
    nextController.transfers = self.currentTransfers;
    nextController.routes = self.currentRoutes;
    

    




}


@end
