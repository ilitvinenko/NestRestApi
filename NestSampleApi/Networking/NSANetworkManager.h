//
//  NSANetworkManager.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NSAJsonResponseBlock)(NSDictionary *response, NSError *error);

@interface NSANetworkManager : NSObject

@property (nonatomic, readonly) NSURL *baseUrl;

+ (instancetype)shared;
- (void)sendRequest:(NSURLRequest *)request withCompletion:(NSAJsonResponseBlock)completions;

@end
