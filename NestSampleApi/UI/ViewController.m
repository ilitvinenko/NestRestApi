//
//  ViewController.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "ViewController.h"
#import "NSAServiceProvider.h"
#import "NSAThermostatDataSource.h"
#import "NSAThermostatInfoViewController.h"

static NSString * const kShowThermostatInfoStoryboardId = @"ShowThermostatInfo";

@interface ViewController () <NSAThermostatDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSAThermostatDataSource *datasource;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datasource = [[NSAThermostatDataSource alloc] initWithTableView:self.tableView noDataView:self.noDataLabel delegate:self];
    self.tableView.tableFooterView = [UIView new];
    
    UIRefreshControl *refresh = [UIRefreshControl new];
    [refresh addTarget:self action:@selector(updateThermostats) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refresh;
    
    [self updateThermostats];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kShowThermostatInfoStoryboardId]) {
        NSAThermostatInfoViewController *destination = (NSAThermostatInfoViewController *)segue.destinationViewController;
        if ([sender isKindOfClass:[Thermostat class]]) {
            destination.thermostat = (Thermostat *)sender;
        } else {
            [[NSException exceptionWithName:NSStringFromClass(self.class) reason:@"Illegal sender parameter" userInfo:nil] raise];
        }
    }
}

#pragma mark - NSAThermostatDataProviderProtocol

- (void)datasource:(NSAThermostatDataSource *)source didSelect:(Thermostat *)item {
    [self performSegueWithIdentifier:kShowThermostatInfoStoryboardId sender:item];
}

#pragma mark - Internal

- (void) updateThermostats {
    [[NSAServiceProvider shared].thermostatDataProvider loadThermostats:^(NSArray<Thermostat *> *result, NSError *error) {
        if (error) {
            [self showErrorAlertWithText:error.localizedDescription];
        }
        self.datasource.items = result;
        [self.tableView.refreshControl endRefreshing];
    }];
}

- (void)showErrorAlertWithText:(NSString *)text {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Something went wrong" message:text preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
