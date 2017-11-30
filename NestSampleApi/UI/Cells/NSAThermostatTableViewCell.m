//
//  NSAThermostatTableViewCell.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "NSAThermostatTableViewCell.h"

@implementation NSAThermostatTableViewCell

+ (NSString *)identifier{
    return [NSString stringWithFormat:@"k%@Identifier", NSStringFromClass(self.class)];
}

+ (void)registerIn:(UITableView *)tableView {
    [tableView registerClass:[NSAThermostatTableViewCell class] forCellReuseIdentifier:self.identifier];
}

- (void)setItem:(Thermostat *)item {
    _item = item;
    [self updateUi];
}

- (void)updateUi {
    self.textLabel.text = self.item.name;
    self.detailTextLabel.text = self.item.locationName;
}

@end
