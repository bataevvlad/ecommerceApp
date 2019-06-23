//
//  InfoViewController.m
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import "InfoViewController.h"
#import "ProductModel.h"
#import "UIImageView+AFNetworking.h"
#import "OrderViewController.h"

@interface InfoViewController ()

@property (weak, nonatomic) ProductModel* model;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)buttonPressed:(id)sender;

@end

@implementation InfoViewController

- (instancetype)initWithProduct:(ProductModel*) model;
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.model.title;
    
    NSURL* url = [NSURL URLWithString:self.model.imageUrl];
    [self.imageView setImageWithURL:url];
    
    self.descriptionLabel.text = self.model.descrFull;
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.adjustsFontSizeToFitWidth = YES;
}

- (IBAction)buttonPressed:(id)sender
{
    OrderViewController* controller = [[OrderViewController alloc] initWithProduct:self.model];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
