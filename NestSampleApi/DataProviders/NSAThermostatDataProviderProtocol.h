//
//  NSAThermostatDataProviderProtocol.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Thermostat.h"

typedef void(^TermostatsResultCallback)(NSArray<Thermostat *> *result, NSError *error);

@protocol NSAThermostatDataProviderProtocol <NSObject>

- (void) loadThermostats: (TermostatsResultCallback)callback;

@end
