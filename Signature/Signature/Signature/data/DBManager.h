//
//  DBManager.h
//  Signature
//
//  Created by Shaoke Xu on 12/31/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+(DBManager *)getSharedInstance;


//======================================================
// brown_bag_list table
//======================================================
// Get brown bag list
// status:
//          1: finished
//          0: not finished
//   not pass: return all
- (NSDictionary *)getBrownBagLists:(NSInteger)status;

/**
 *
 */
- (NSDictionary *)createABrownBag:(NSDictionary *)brownBagItem;

- (NSDictionary *)getABrownBag:(NSDictionary *)brownBagItem;

- (NSDictionary *)updateABrownBag:(NSDictionary *)brownBagItem;

- (NSDictionary *)deleteABrownBag:(NSDictionary *)brownBagItem;

//======================================================
// signature_images table
//======================================================
- (NSDictionary *)getSignatureImagesByBrownBag:(NSDictionary *)brownBagID;

- (NSDictionary *)createASignature:(NSDictionary *)signatureInfo;

- (NSDictionary *)getASignature:(NSDictionary *)signatureID;

- (NSDictionary *)updateASignature:(NSDictionary *)signatureInfo;

- (NSDictionary *)deleteASignature:(NSDictionary *)signatureID;

@end
