//
//  ProductModel.h
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : NSObject

- (instancetype)initWithDict:(NSDictionary*)dict;

@property (strong, nonatomic) NSString* identifier;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* descrShort;
@property (strong, nonatomic) NSString* descrFull;
@property (strong, nonatomic) NSString* imageUrl;
@property (strong, nonatomic) NSString* price;

@end

NS_ASSUME_NONNULL_END
