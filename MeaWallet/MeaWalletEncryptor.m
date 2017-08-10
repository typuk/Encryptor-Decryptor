//
//  MeaWalletEncryptor.m
//  MeaWallet
//
//  Created by Alehna, Arturs on 6/16/17.
//  Copyright © 2017 Alehna, Arturs. All rights reserved.
//

#import "MeaWalletEncryptor.h"
#import "NSString+MeaWallet.h"

@implementation MeaWalletEncryptor

+ (nullable NSString *)encryptNumericString:(nonnull NSString *)data withPassword:(nonnull NSString *)password {
    
    if (![data isValidForNumericEncryptionAndDecrytion] || ![password isValidForNumericEncryptionAndDecrytion]) {
        return nil;
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    [data enumerateSubstringsInRange:NSMakeRange(0, data.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop)
     {
         NSInteger value = substring.integerValue;
         NSInteger key = [password substringWithRange:NSMakeRange(substringRange.location % password.length, 1)].integerValue;
         [string appendFormat:@"%li", (value + key) % 10];
     }];

    return string;
}

+ (nullable NSString *)encryptAgnosticString:(nonnull NSString *)data withPassword:(nonnull NSString *)password {
    
    if (![data length] || ![password length]) {
        return nil;
    }
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    for (int i = 0; i < data.length; i++) {
        int value = [data characterAtIndex:i];
        int key = [password characterAtIndex:i % password.length];
        [string appendFormat:@"%C", (unichar)((value + key) % 1112064)];
    }

    return string;
}

@end
