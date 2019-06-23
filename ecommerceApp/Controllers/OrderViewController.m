//
//  OrderViewController.m
//  ecommerceApp
//
//  Created by Admin on 6/20/19.
//  Copyright © 2019 bataevvlad. All rights reserved.
//

#import "OrderViewController.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "ProductModel.h"
#import "OrderModel.h"

#define ALPHA                   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC                 @"1234567890"
#define ALPHA_NUMERIC           ALPHA NUMERIC

@interface OrderViewController () <UITextFieldDelegate>

@property (weak, nonatomic) ProductModel* model;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *allFields;


@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)buttonPressed:(id)sender;


@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation OrderViewController

- (instancetype)initWithProduct:(ProductModel*) model
{
    self = [super init];
    if (self) {
        self.model = model;
        self.ref = [[[FIRDatabase databaseWithURL:@"https://vbecommerce-5555a.firebaseio.com/"] reference] child:@"order"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.firstNameTextField becomeFirstResponder];
    
    self.title = @"Complete order";
}

- (IBAction)buttonPressed:(id)sender
{
    
    OrderModel* model = [[OrderModel alloc] init];
    model.productIdentifier = self.model.identifier;
    model.firstName = self.firstNameTextField.text;
    model.lastName = self.lastNameTextField.text;
    model.email = self.emailTextField.text;
    model.address = self.addressTextField.text;
    
    NSDictionary* json = [model json];
    
    __weak typeof(self) weakSelf = self;
    [self.ref setValue:json withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        UINavigationController* navigationController = weakSelf.navigationController;
        [navigationController popToRootViewControllerAnimated:YES];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Готово!" message:@"Заказ сформирован. В ближайшее время с вами свяжется менеджер." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ок, супер!" style:UIAlertActionStyleDefault handler:nil]];
        [navigationController presentViewController:alert animated:YES completion:nil];
    }];
}

#pragma mark Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 101) {
        [self.lastNameTextField becomeFirstResponder];
    } else if (textField.tag == 102) {
        [self.emailTextField becomeFirstResponder];
    } else if (textField.tag == 103) {
        [self.addressTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //smoothly look for phone number and correct email;
    if (textField.tag == 104) {
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        //+XXX (XX) XXX-XXXX;
        NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        newString = [validComponents componentsJoinedByString:@""];
        
        //XXXXXXXXXXXX;
        static const int localNumberMaxLength = 7;
        static const int areaCodeMaxLength = 2;
        static const int countryCodeMaxLength = 3;
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
            return NO;
        }
        
        NSMutableString *resultString = [NSMutableString string];
        
        //+XX (XXX) XXX-XXXX;
        NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
        
        if (localNumberLength > 0) {
            NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            [resultString appendString:number];
            
            if ([resultString length] > 3) {
                [resultString insertString:@"-" atIndex:3];
            }
        }
        
        if ([newString length] > localNumberMaxLength) {
            
            NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
            
            NSString *area = [newString substringWithRange:areaRange];
            
            area = [NSString stringWithFormat:@"(%@)", area];
            
            [resultString insertString:area atIndex:0];
        }
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
            
            NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
            
            NSRange countryRange = NSMakeRange(0, countryCodeLength);
            
            NSString *countryCode = [newString substringWithRange:countryRange];
            
            countryCode = [NSString stringWithFormat:@"+%@", countryCode];
            
            [resultString insertString:countryCode atIndex:0];
        }
        
        textField.text = resultString;
        
        return NO;
    }
    
    if (textField.tag == 103) {
        
        NSCharacterSet *unacceptedInput = nil;
        if ([[textField.text componentsSeparatedByString:@"@"] count] > 1) {
            unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC
                                                                                   stringByAppendingString:@".-"]] invertedSet];
        } else {
            unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:[ALPHA_NUMERIC
                                                                                   stringByAppendingString:@".!#$%&'*+-/=?^_`{|}~@"]] invertedSet];
        }
        return ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1);
    }
    return YES;
}

@end
