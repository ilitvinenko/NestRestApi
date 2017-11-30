//
//  NSANetworkManager+ThermostatLoader.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "NSANetworkManager.h"
#import "NSAThermostatDataProviderProtocol.h"

@interface NSANetworkManager (ThermostatLoader) <NSAThermostatDataProviderProtocol>

@end
