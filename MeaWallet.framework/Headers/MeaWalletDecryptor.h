//
//  MeaWalletDecryptor.h
//  MeaWallet
//
//  Created by Alehna, Arturs on 6/16/17.
//  Copyright © 2017 Alehna, Arturs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeaWalletDecryptor : NSObject

+ (nullable NSString *)decryptNumericString:(nonnull NSString *)encryptedData withPassword:(nonnull NSString *)password;

/**
 Purpose of this function is to decrypt UTF-16 chracters and return decrypted string. If data or password is nil
 returns nil string.
 */
+ (nullable NSString *)decryptAgnosticString:(nonnull NSString *)data withPassword:(nonnull NSString *)password;

@end
