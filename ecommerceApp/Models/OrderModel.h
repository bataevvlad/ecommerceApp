//
//  OrderModel.h
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject

@property (strong, nonatomic) NSString* productIdentifier;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* address;

- (NSDictionary*)json;

@end

NS_ASSUME_NONNULL_END
