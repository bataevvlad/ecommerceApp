//
//  UIRefreshControl+beginRefresh.m
//  ecommerceApp
//
//  Created by Admin on 24.06.19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import "UIRefreshControl+beginRefresh.h"

@implementation UIRefreshControl (beginRefresh)

- (void)beginRefreshingProgrammatically {
    [self endRefreshing];
    [self setTintColor:[UIColor whiteColor]];
    [self performSelector:@selector(startRefreshingProgrammatically) withObject:nil afterDelay:0];
}

- (void)startRefreshingProgrammatically {
    
    UITableView *tableView = [self getParentTableViewOfView:self];
    if (tableView) {
        [tableView setContentOffset:CGPointMake(0, tableView.contentOffset.y-self.frame.size.height) animated:NO];
    }
    
    [self setTintColor:[UIColor whiteColor]];
    [self beginRefreshing];
}

// recursively find a UITableView in superviews
- (UITableView *)getParentTableViewOfView:(UIView*)view {
    if ([view.superview isKindOfClass:[UITableView class]]) {
        return (UITableView *)view.superview;
    }
    return nil;
}

@end
