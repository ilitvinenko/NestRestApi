//
//  Thermostat.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

@import Foundation;

@interface Thermostat : NSObject

@property (nonatomic, readonly) NSNumber * humidity;
@property (nonatomic, readonly) NSString * locationId;
@property (nonatomic, readonly) NSString * deviceId;
@property (nonatomic, readonly) NSString * name;
@property (nonatomic, readonly) float temperatureC;
@property (nonatomic, readonly) NSString * locationName;

- (instancetype) initWithDictionary:(NSDictionary *) source;

@end
