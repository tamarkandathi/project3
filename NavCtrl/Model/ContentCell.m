//
//  ContentCell.m
//  NavCtrl
//
//  Created by Tamar on 1/3/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.nameLabel = [[UILabel alloc] init];
        self.stockPriceLabel = [[UILabel alloc] init];
        self.stockPriceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.stockPriceLabel];
        self.nameLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
        self.stockPriceLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    }
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    float x, y, width, height;
    x = y = 0;
    width = height = 80;
    self.imageView.frame = CGRectMake(x, y, width, height);
    x += width + 40;
    width = 400;
    self.nameLabel.frame = CGRectMake(x, y, width, height);
    x += width;
    width = 768 - x - 40;
    self.stockPriceLabel.frame = CGRectMake(x, y, width, height);
}

- (void)setSelected:(BOOL)selected {
    if(selected)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
}
@end
