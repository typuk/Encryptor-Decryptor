//
//  MeaWalletEncryptor.h
//  MeaWallet
//
//  Created by Alehna, Arturs on 6/16/17.
//  Copyright © 2017 Alehna, Arturs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeaWalletEncryptor : NSObject

/**
 
 */
+ (nullable NSString *)encryptNumericString:(nonnull NSString *)data withPassword:(nonnull NSString *)password;

/**
 Purpose of this function is to encrypt UTF-16 chracters and return encrypted string. If data or password is nil 
 returns nil string.
 */
+ (nullable NSString *)encryptAgnosticString:(nonnull NSString *)data withPassword:(nonnull NSString *)password;

@end
