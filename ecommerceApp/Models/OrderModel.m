//
//  OrderModel.m
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (NSDictionary*)json
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    if (self.productIdentifier)
    {
        [dict setObject:self.productIdentifier forKey:@"productIdentifier"];
    }
    if (self.firstName)
    {
        [dict setObject:self.firstName forKey:@"firstName"];
    }
    if (self.lastName)
    {
        [dict setObject:self.lastName forKey:@"lastName"];
    }
    if (self.email)
    {
        [dict setObject:self.email forKey:@"email"];
    }
    if (self.address)
    {
        [dict setObject:self.address forKey:@"address"];
    }
    
    return [dict copy];
}


@end
