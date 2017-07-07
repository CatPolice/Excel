//
//  BCMyTableViewCell.m
//  xxxxxxxx
//
//  Created by WF on 2017/1/5.
//  Copyright © 2017年 WF. All rights reserved.
//

#import "BCMyTableViewCell.h"

@implementation BCMyTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _label.layer.borderColor = [UIColor blackColor].CGColor;
        _label.layer.borderWidth = 0.5f;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:17.f];
        [self addSubview:_label];
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

@end
