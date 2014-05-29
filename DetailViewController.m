//
//  DetailViewController.m
//  GetOnThebus
//
//  Created by Joanne McNamee on 5/28/14.
//  Copyright (c) 2014 JMWHS. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *transfersLabel;
@property (weak, nonatomic) IBOutlet UILabel *routesLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addressLabel.text = self.address;
    if (self.transfers == nil)
    {
        self.transfersLabel.text = @"No transfers this stop";
    }
    else
    {
        self.transfersLabel.text = self.transfers;
    }

    self.routesLabel.text = self.routes;
    
}


@end
