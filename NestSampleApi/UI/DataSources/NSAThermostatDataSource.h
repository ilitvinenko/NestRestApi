//
//  NSAThermostatDataSource.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

@import UIKit;
#import "Thermostat.h"

@protocol NSAThermostatDataSourceDelegate;

@interface NSAThermostatDataSource : NSObject

@property (nonatomic, copy) NSArray<Thermostat *> *items;
@property (nonatomic, assign) id<NSAThermostatDataSourceDelegate> delegate;

- (instancetype)initWithTableView:(UITableView *)tableView noDataView:(UIView *)noData delegate:(id<NSAThermostatDataSourceDelegate>)delegate;

@end

@protocol NSAThermostatDataSourceDelegate

- (void)datasource:(NSAThermostatDataSource *)source didSelect:(Thermostat *)item;

@end
