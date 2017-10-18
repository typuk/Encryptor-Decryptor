//
//  NSString+MeaWallet.m
//  MeaWallet
//
//  Created by Alehna, Arturs on 6/16/17.
//  Copyright © 2017 Alehna, Arturs. All rights reserved.
//

#import "NSString+MeaWallet.h"

@implementation NSString (MeaWallet)

- (BOOL)isValidForNumericEncryptionAndDecrytion {
    
    if (!self.length || !self) {
        return NO;
    }
    
    NSCharacterSet *notNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [self rangeOfCharacterFromSet:notNumbers].location == NSNotFound;
}

@end
