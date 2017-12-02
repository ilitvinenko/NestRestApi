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
@property (weak, nonatomic) IBOutlet UILabel *targetTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *modeLabel;

@end

@implementation NSAThermostatInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.thermostat.name;
    
    self.temperatureValueLabel.text = [NSString stringWithFormat:@"%2.1f", self.thermostat.currentTemperatureC];
    self.targetTemperatureLabel.text = [NSString stringWithFormat:@"%2.1f", self.thermostat.targetTemperatureC];
    self.locationValueLabel.text = self.thermostat.locationName;
    self.humidityValueLabel.text = self.thermostat.humidity.stringValue;
    
    NSString *modeText = nil;
    switch (self.thermostat.mode) {
        case NSAThermostatModeEco:
            modeText = @"Eco";
            break;
        case NSAThermostatModeHeating:
            modeText = @"Heating";
            break;
    }
    self.modeLabel.text = modeText;
}


@end
