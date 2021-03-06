//
//  Thermostat.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "Thermostat.h"

@interface Thermostat()

@property (nonatomic, readwrite, copy) NSNumber * humidity;
@property (nonatomic, readwrite, copy) NSString * locationId;
@property (nonatomic, readwrite, copy) NSString * deviceId;
@property (nonatomic, readwrite, copy) NSString * name;
@property (nonatomic, readwrite, assign) float currentTemperatureC;
@property (nonatomic, readwrite, assign) float targetTemperatureC;
@property (nonatomic, readwrite, copy) NSString * locationName;
@property (nonatomic, readwrite, assign) NSAThermostatMode mode;

@end

@implementation Thermostat

- (instancetype)init {
    [[NSException exceptionWithName:@"Illegal Constructor Call" reason:@"Please use initWithDictionary:" userInfo:nil] raise];
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)source {
    if (self = [super init]) {
        self.humidity = source[@"humidity"];
        self.locationId = source[@"where_id"];
        self.deviceId = source[@"device_id"];
        self.name = source[@"name"];
        self.currentTemperatureC = [source[@"ambient_temperature_c"] floatValue];
        self.targetTemperatureC = [source[@"target_temperature_c"] floatValue];
        self.locationName = source[@"where_name"];
        self.mode = [self modeForString:source[@"hvac_mode"]];
    }
    
    return self;
}

- (NSAThermostatMode)modeForString:(NSString *)source {
    NSAThermostatMode result;
    if ([source isEqualToString:@"heat"]) {
        result = NSAThermostatModeHeating;
    } else {
        result = NSAThermostatModeEco;
    }
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@]: id: %@, name: %@, location: %@", NSStringFromClass(self.class), self.deviceId, self.name, self.locationName];
}

@end
