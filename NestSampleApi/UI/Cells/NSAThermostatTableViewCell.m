//
//  NSAThermostatTableViewCell.m
//  NestSampleApi
//
//  Created by Igor Litvinenko on 11/26/17.
//  Copyright © 2017 Igor Litvinenko. All rights reserved.
//

#import "NSAThermostatTableViewCell.h"

@interface NSAThermostatTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *modeImageView;


@end

@implementation NSAThermostatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (NSString *)identifier{
    return [NSString stringWithFormat:@"k%@Identifier", NSStringFromClass(self.class)];
}

+ (void)registerIn:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil] forCellReuseIdentifier:[NSAThermostatTableViewCell identifier]];
}

- (void)setItem:(Thermostat *)item {
    _item = item;
    [self updateUi];
}

- (void)updateUi {
    self.nameLabel.text = self.item.name;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%2.0f", self.item.currentTemperatureC];
    
    NSString *imageName = nil;
    switch (self.item.mode) {
        case NSAThermostatModeEco:
            imageName = @"eco";
            break;
        case NSAThermostatModeHeating:
            imageName = @"heat";
            break;
    }
    
    self.modeImageView.image = [UIImage imageNamed:imageName];
}

@end
