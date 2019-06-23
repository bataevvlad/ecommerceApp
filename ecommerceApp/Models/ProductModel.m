//
//  ProductModel.m
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        self.identifier = dict[@"identifier"];
        self.title = dict[@"title"];
        self.descrShort = dict[@"descrShort"];
        self.descrFull = dict[@"descrFull"];
        self.imageUrl = dict[@"imageUrl"];
        self.price = dict[@"price"];
    }
    return self;
}

@end
