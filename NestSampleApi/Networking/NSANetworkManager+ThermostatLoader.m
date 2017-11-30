//
//  NSANetworkManager+ThermostatLoader.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "NSANetworkManager+ThermostatLoader.h"

@implementation NSANetworkManager (ThermostatLoader)

- (void)loadThermostats:(TermostatsResultCallback)callback {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.baseUrl];
    request.HTTPMethod = @"GET";
    
    [self sendRequest:request withCompletion:^(NSDictionary *response, NSError *error) {
        if (!callback) { return ;}
        
        if (!response || error) {
            callback(nil, error);
        } else {
            NSDictionary *sources = [response valueForKeyPath:@"devices.thermostats"];
            NSMutableArray <Thermostat *> *result = [NSMutableArray arrayWithCapacity:sources.allValues.count];
            for (NSDictionary *item in sources.allValues) {
                Thermostat *thermostat = [[Thermostat alloc] initWithDictionary:item];
                if (thermostat) {
                    [result addObject:thermostat];
                }
            }
            
            callback(result.copy, error);
        }
    }];
}

@end
