//
//  NSAThermostatTableViewCell.h
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thermostat.h"

@interface NSAThermostatTableViewCell : UITableViewCell

@property (nonatomic, strong) Thermostat *item;

+ (NSString *)identifier;
+ (void)registerIn:(UITableView *)tableView;

@end
