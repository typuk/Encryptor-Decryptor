//
//  MeaWalletTests.m
//  MeaWalletTests
//
//  Created by Alehna, Arturs on 6/16/17.
//  Copyright © 2017 Alehna, Arturs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MeaWallet/MeaWallet.h>

@interface MeaWalletTests : XCTestCase

@end

@implementation MeaWalletTests

- (void)testEncryptionPositiveScenarios {
    
    // Testing MeaWalletEncoder positive scenarios
    
    NSString *encryptedString = [MeaWalletEncryptor encryptNumericString:@"1234567890" withPassword:@"123"];
    XCTAssertTrue([encryptedString isEqualToString:@"2465798021"], @"expected to successfully encrypt data when password is shorter than data");
    
    encryptedString = [MeaWalletEncryptor encryptNumericString:@"1234567890" withPassword:@"6483187630"];
    XCTAssertTrue([encryptedString isEqualToString:@"7617644420"], @"expected to successfully encrypt data when password is the same lenght as data");
    
    encryptedString = [MeaWalletEncryptor encryptNumericString:@"1234567890" withPassword:@"94894864494894"];
    XCTAssertTrue([encryptedString isEqualToString:@"0613943239"], @"expected to successfully encrypt data when password is longer than data");
}

- (void)testEncryptionFailedScenarios {
    
    // Testing MeaWalletEncoder negative scenarios
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    NSString *encryptedString = [MeaWalletEncryptor encryptNumericString:nil withPassword:nil];
#pragma clang diagnostic pop
    XCTAssertNil(encryptedString, @"expected encrypt to fail when password and data are missing");
    
    encryptedString = [MeaWalletEncryptor encryptNumericString:@"" withPassword:@""];
    XCTAssertNil(encryptedString, @"expected encrypt to fail when password and data are empty");
    
    encryptedString = [MeaWalletEncryptor encryptNumericString:@"12345+&6" withPassword:@"dadad"];
    XCTAssertNil(encryptedString, @"expected encrypt to fail when password and data contains invalid characters");
}

- (void)testDecryptionPositiveScenarios {
    
    // Testing MeaWalletDecoder positive scenarios
    
    NSString *decryptedString = [MeaWalletDecryptor decryptNumericString:@"2465798021" withPassword:@"123"];
    XCTAssertTrue([decryptedString isEqualToString:@"1234567890"], @"expected to successfully decrypt data when password is shorter than data");
    
    decryptedString = [MeaWalletDecryptor decryptNumericString:@"7617644420" withPassword:@"6483187630"];
    XCTAssertTrue([decryptedString isEqualToString:@"1234567890"], @"expected to successfully decrypt data when password is the same lenght as data");
    
    decryptedString = [MeaWalletDecryptor decryptNumericString:@"0613943239" withPassword:@"94894864494894"];
    XCTAssertTrue([decryptedString isEqualToString:@"1234567890"], @"expected to successfully decrypt data when password is longer than data");
    
    decryptedString = [MeaWalletEncryptor encryptAgnosticString:@"nandoadni232" withPassword:@"mdad343"];
    NSString *decoded = [MeaWalletDecryptor decryptAgnosticString:decryptedString withPassword:@"mdad343"];
    XCTAssertTrue([decoded isEqualToString:@"nandoadni232"], @"expected to successfully decrypt data when password is longer than data");
}

- (void)testDecryptionFailedScenarios {
    
    // Testing MeaWalletDecoder negative scenarios
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    NSString *encryptedString = [MeaWalletDecryptor decryptNumericString:nil withPassword:nil];
#pragma clang diagnostic pop
    XCTAssertNil(encryptedString, @"expected decrypt to fail when password and data are missing");
    
    encryptedString = [MeaWalletDecryptor decryptNumericString:@"" withPassword:@""];
    XCTAssertNil(encryptedString, @"expected decrypt to fail when password and data are empty");
    
    encryptedString = [MeaWalletDecryptor decryptNumericString:@"12345+&6" withPassword:@"dadad"];
    XCTAssertNil(encryptedString, @"expected decrypt to fail when password and data contains invalid characters");
}

- (void)testAgnosticEncyptionAndDecription {
    
    NSString *encryptedString = [MeaWalletEncryptor encryptAgnosticString:@"Lorem Ipsum" withPassword:@"test key"];
    NSString *decryptedString = [MeaWalletDecryptor decryptAgnosticString:encryptedString withPassword:@"test key"];
    
    XCTAssertTrue([@"Lorem Ipsum" isEqualToString:decryptedString], @"expected to successfully encrypt and decrypt data");
    
    encryptedString = [MeaWalletEncryptor encryptAgnosticString:@"Lorem Ipsum ☹️⚽️🎶" withPassword:@"test key"];
    decryptedString = [MeaWalletDecryptor decryptAgnosticString:encryptedString withPassword:@"test key"];
    
    XCTAssertTrue([@"Lorem Ipsum ☹️⚽️🎶" isEqualToString:decryptedString], @"expected to successfully encrypt and decrypt data with emojis");
}

@end
