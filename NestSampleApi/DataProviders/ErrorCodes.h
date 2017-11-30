//
//  ErrorCodes.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#ifndef ErrorCodes_h
#define ErrorCodes_h

typedef NS_ENUM(NSUInteger, NSANetworkErrorCode) {
    NSANetworkErrorCodeUnknown = 0,
    NSANetworkErrorCodeNetworkError = 1,
    NSANetworkErrorCodeEmptyData = 2,
    NSANetworkErrorCodeUnathorizedRequest = 3
};

#endif /* ErrorCodes_h */
