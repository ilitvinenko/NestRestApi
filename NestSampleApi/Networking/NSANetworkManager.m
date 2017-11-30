//
//  NSANetworkManager.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "NSANetworkManager.h"
#import "ErrorCodes.h"

static NSString * const kBaseRequestUrl = @"https://developer-api.nest.com";
static NSString * const kRequestToken = @"";

static NSString * const kAuthorizationKey = @"Authorization";

@interface NSANetworkManager() <NSURLSessionDataDelegate>

@property (nonatomic, readwrite, strong) NSURL *baseUrl;
@property (nonatomic, strong) NSURLSession *activeSession;

@end

@implementation NSANetworkManager

#pragma mark - Public Interface
+ (instancetype)shared {
    static NSANetworkManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [NSANetworkManager new];
    });
    return shared;
}

- (NSURL *)baseUrl {
    if (!_baseUrl) {
        _baseUrl = [NSURL URLWithString:kBaseRequestUrl];
        NSAssert(_baseUrl != nil, @"Incorrect base url");
    }
    return _baseUrl;
}

- (void)sendRequest:(NSURLRequest *)request withCompletion:(NSAJsonResponseBlock)completions {
    NSURLSessionDataTask *task = [self.activeSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSInteger requestCode = [(NSHTTPURLResponse *)response statusCode];
        
        if (error) {
            [self performBlock:completions withResult:nil andError:error];
        } else if (requestCode != 200) {
            NSString *message = [NSHTTPURLResponse localizedStringForStatusCode:requestCode];
            NSError *serverError = [NSError errorWithDomain:NSStringFromClass(self.class) code:NSANetworkErrorCodeNetworkError userInfo:@{NSLocalizedDescriptionKey: message}];
            [self performBlock:completions withResult:nil andError:serverError];
        } else if (data.length == 0) {
            NSError *dataError = [NSError errorWithDomain:NSStringFromClass(self.class) code:NSANetworkErrorCodeEmptyData userInfo:nil];
            [self performBlock:completions withResult:nil andError:dataError];
        } else {
            NSError *parseError = nil;
            NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            if (parseError) {
                [self performBlock:completions withResult:nil andError:parseError];
            } else {
                NSError *serverError = [self extractErrorFromResponse:parsedResponse];
                if (serverError) {
                    [self performBlock:completions withResult:nil andError:serverError];
                } else {
                    [self performBlock:completions withResult:parsedResponse andError:nil];
                }
            }
        }
    }];
    [task resume];
}

#pragma mark - Internal

- (NSError *)extractErrorFromResponse: (NSDictionary *)response {
    NSString *error = response[@"error"];
    NSError *result;
    if (error.length > 0) {
        NSANetworkErrorCode code = NSANetworkErrorCodeUnknown;
        if ([error isEqualToString:@"unauthorized"]) {
            code = NSANetworkErrorCodeUnathorizedRequest;
        }
        
        result = [NSError errorWithDomain:NSStringFromClass(self.class) code:code userInfo:response];
    }
    return result;
}

- (NSURLSession *)activeSession {
    if (!_activeSession) {
        NSAssert(kRequestToken.length > 0, @"Please fill requst token");
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPAdditionalHeaders = @{
                                                @"Content-Type": @"application/json; charset=UTF-8",
                                                kAuthorizationKey: kRequestToken
                                                };
        
        _activeSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        
    }
    return _activeSession;
}


- (void)performBlock:(NSAJsonResponseBlock)block withResult: (NSDictionary *)result andError:(NSError *)error {
    if (!block) { return;}
    
    dispatch_async(dispatch_get_main_queue(), ^{
        block(result, error);
    });
}

#pragma mark - NSURLSession delegate

//pass authorization header for redirected requests
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    
    NSString *authorization = response.allHeaderFields[kAuthorizationKey];
    NSURLRequest *requestToProceed = request;
    
    if (!request.allHTTPHeaderFields[kAuthorizationKey] && authorization.length > 0) {
        NSMutableURLRequest *corrected = request.mutableCopy;
        [corrected setValue:authorization forHTTPHeaderField:kAuthorizationKey];
        requestToProceed = corrected.copy;
    }
    
    completionHandler(requestToProceed);
}
@end
