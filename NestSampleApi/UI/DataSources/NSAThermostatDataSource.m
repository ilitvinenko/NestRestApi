//
//  NSAThermostatDataSource.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "NSAThermostatDataSource.h"
#import "NSAThermostatTableViewCell.h"

@interface NSAThermostatDataSource() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *noDataView;

@end

@implementation NSAThermostatDataSource

- (instancetype)initWithTableView:(UITableView *)tableView noDataView:(UIView *)noData delegate:(id<NSAThermostatDataSourceDelegate>)delegate {
    if (self = [super init]) {
        self.tableView = tableView;
        self.noDataView = noData;
        tableView.delegate = self;
        tableView.dataSource = self;
        [NSAThermostatTableViewCell registerIn:tableView];
        self.delegate = delegate;
    }
    return self;
}

- (void)setItems:(NSArray<Thermostat *> *)items {
    _items = items.copy;
    [self.tableView reloadData];
    self.noDataView.hidden = _items.count > 0;
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAThermostatTableViewCell *cell = (NSAThermostatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSAThermostatTableViewCell.identifier forIndexPath:indexPath];
    cell.item = self.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([(NSObject *)self.delegate respondsToSelector:@selector(datasource:didSelect:)]) {
        [self.delegate datasource:self didSelect:self.items[indexPath.row]];
    }
}

@end
