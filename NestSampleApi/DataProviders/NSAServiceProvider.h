//
//  ServiceProvider.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSAThermostatDataProviderProtocol.h"

@interface NSAServiceProvider : NSObject

+ (instancetype) shared;

- (id<NSAThermostatDataProviderProtocol>) thermostatDataProvider;

@end
