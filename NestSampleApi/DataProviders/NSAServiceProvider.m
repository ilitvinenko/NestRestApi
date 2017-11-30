//
//  ServiceProvider.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "NSAServiceProvider.h"
#import "NSANetworkManager+ThermostatLoader.h"

@implementation NSAServiceProvider

+ (instancetype)shared {
    static NSAServiceProvider *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [NSAServiceProvider new];
    });
    return shared;
}

- (id<NSAThermostatDataProviderProtocol>)thermostatDataProvider {
    return [NSANetworkManager shared];
}

@end
