//
//  ProductCell.m
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import "ProductCell.h"
#import "ProductModel.h"
#import "UIImageView+AFNetworking.h"

@implementation ProductCell

- (void)setModel:(ProductModel *)model
{
    _model = model;
    
    NSURL* url = [NSURL URLWithString:model.imageUrl];
    [self.imgView setImageWithURL:url];
    
    self.titleLabel.text = model.title;
    self.descriptionLabel.text = model.descrShort;
    self.priceLabel.text = model.price;
    
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.descriptionLabel.adjustsFontSizeToFitWidth = YES;
    
}

@end
