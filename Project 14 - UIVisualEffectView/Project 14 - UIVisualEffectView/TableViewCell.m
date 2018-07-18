//
//  TableViewCell.m
//  Project 14 - UIVisualEffectView
//
//  Created by Jamie on 2018/7/18.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:self.picView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImageView *)picView {
    if (!_picView) {
        _picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, 80)];
    }
    return _picView;
}

@end
