//
//  GoodsViewController.h
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong,nonatomic) UIRefreshControl * refreshControl;


@end

NS_ASSUME_NONNULL_END
