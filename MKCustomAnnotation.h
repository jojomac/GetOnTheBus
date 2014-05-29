//
//  MKCustomAnnotation.h
//  GetOnThebus
//
//  Created by Joanne McNamee on 5/28/14.
//  Copyright (c) 2014 JMWHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKPointAnnotation.h>


@interface MKCustomAnnotation : MKPointAnnotation

@property  NSString *address;

@property  NSString *routes;

@property NSString *transfers;





@end
