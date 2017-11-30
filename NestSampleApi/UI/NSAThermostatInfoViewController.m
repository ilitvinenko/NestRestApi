//
//  NSAThermostatInfoViewController.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "NSAThermostatInfoViewController.h"

@interface NSAThermostatInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *temperatureValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityValueLabel;

@end

@implementation NSAThermostatInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.thermostat.name;
    
    self.temperatureValueLabel.text = [NSString stringWithFormat:@"%2.1f", self.thermostat.temperatureC];
    self.locationValueLabel.text = self.thermostat.locationName;
    self.humidityValueLabel.text = self.thermostat.humidity.stringValue;
}


@end
