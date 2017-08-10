//
//  MeaWalletViewController.m
//  MeaWalletApp
//
//  Created by Alehna, Arturs on 6/16/17.
//  Copyright © 2017 Alehna, Arturs. All rights reserved.
//

#import "MeaWalletViewController.h"
#import <MeaWallet/MeaWallet.h>

@interface MeaWalletViewController ()

@property (weak, nonatomic) IBOutlet UITextField *dataTextField;
@property (weak, nonatomic) IBOutlet UITextField *resultTextField;

@end

@implementation MeaWalletViewController

- (IBAction)onButtonEncrypt:(id)sender {
    [self presentPasswordAlertWithBlock:^(NSString *password) {
        NSString *encryptedValue = [MeaWalletEncryptor encryptAgnosticString:self.dataTextField.text
                                                                withPassword:password];
        self.resultTextField.text = encryptedValue;
    }];
}

- (IBAction)onButtonDecrypt:(id)sender {
    [self presentPasswordAlertWithBlock:^(NSString *password) {
        NSString *decryptedValue = [MeaWalletDecryptor decryptAgnosticString:self.dataTextField.text
                                                                withPassword:password];
        self.resultTextField.text = decryptedValue;
    }];
}

- (void)presentPasswordAlertWithBlock:(void (^)(NSString *))block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Password Entry"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Please provide password";
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(alertController.textFields.firstObject.text);
        }
    }];
    [alertController addAction:confirmAction];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
