//
//  OrderViewController.h
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ProductModel;

@interface OrderViewController : UIViewController <UITextFieldDelegate>

- (instancetype)initWithProduct:(ProductModel*) model;


@end

NS_ASSUME_NONNULL_END
