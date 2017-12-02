//
//  Thermostat.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSUInteger, NSAThermostatMode) {
    NSAThermostatModeEco = 1,
    NSAThermostatModeHeating = 2
};

@interface Thermostat : NSObject

@property (nonatomic, readonly) NSNumber * humidity;
@property (nonatomic, readonly) NSString * locationId;
@property (nonatomic, readonly) NSString * deviceId;
@property (nonatomic, readonly) NSString * name;
@property (nonatomic, readonly) float currentTemperatureC;
@property (nonatomic, readonly) float targetTemperatureC;
@property (nonatomic, readonly) NSString * locationName;
@property (nonatomic, readonly) NSAThermostatMode mode;

- (instancetype) initWithDictionary:(NSDictionary *) source;

@end
