//
//  GoodsViewController.m
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import "GoodsViewController.h"
#import "ProductCell.h"
#import "ProductModel.h"
#import "InfoViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>

@interface GoodsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSMutableArray <ProductModel*> * productsArray;
@end

@implementation GoodsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.productsArray = [[NSMutableArray alloc] init];
        self.ref = [[[FIRDatabase databaseWithURL:@"https://vbecommerce-5555a.firebaseio.com"] reference]  child:@"products"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Book store";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView.refreshControl addTarget:self action:@selector(reloadProducts) forControlEvents:UIControlEventValueChanged];
    [self reloadProducts];
}

#pragma mark TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.productsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.productsArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductModel* model = self.productsArray[indexPath.row];
    InfoViewController* controller = [[InfoViewController alloc] initWithProduct:model];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark Reload

- (void)reloadProducts {
    __weak typeof(self) weakSelf = self;
    [self.ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        [weakSelf.productsArray removeAllObjects];
        
        NSArray* response = snapshot.value;
        
        [response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //for pass nil object;
            if ([obj isKindOfClass:[NSDictionary class]]) {
                ProductModel* model = [[ProductModel alloc] initWithDict:obj];
                [weakSelf.productsArray addObject:model];
            }
        }];
        [weakSelf.tableView reloadData];
    }];
}
@end
