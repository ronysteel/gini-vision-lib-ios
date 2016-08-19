//
//  AnalysisManager.h
//  GiniVisionExampleObjC
//
//  Created by Peter Pult on 11/08/16.
//  Copyright © 2016 Gini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CancelationToken.h"
#import <Gini_iOS_SDK/GiniSDK.h>

extern NSString * _Nonnull const GINIAnalysisManagerDidReceiveResultNotification;
extern NSString * _Nonnull const GINIAnalysisManagerDidReceiveErrorNotification;
extern NSString * _Nonnull const GINIAnalysisManagerResultDictionaryUserInfoKey;
extern NSString * _Nonnull const GINIAnalysisManagerErrorUserInfoKey;
extern NSString * _Nonnull const GINIAnalysisManagerDocumentUserInfoKey;

@interface AnalysisManager : NSObject

@property (nonatomic, strong) NSError  * _Nullable error;
@property (nonatomic, strong) NSDictionary * _Nullable result;
@property (nonatomic, strong) GINIDocument * _Nullable document;

/**
 *  Singleton method returning an instance of the analysis manager.
 *
 *  @return Instance of analysis manager.
 */
+ (nonnull instancetype)sharedManager;

/**
 *  Cancels all running analsis processes manually.
 */
- (void)cancelAnalysis;

/**
 *  Analyzes the given image data returning possible extraction values.
 *
 *  @note Only one analysis process can be running at a time.
 *
 *  @param data       The image data to be analyzed.
 *  @param token      The cancelation token.
 *  @param completion The completion block handling the result.
 */
- (void)analyzeDocumentWithImageData:(nonnull NSData *)data
                    cancelationToken:(nonnull CancelationToken *)token
                       andCompletion:(nullable void (^)(NSDictionary * _Nullable, GINIDocument * _Nullable, NSError * _Nullable))completion;

@end
