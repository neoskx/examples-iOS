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


/** @name brown_bag_list table */

/* Get brown bag list based on the status your passed.
 
 @param status The status your want to check.
 - **1**: finished
 - **0**: not finished
 - **-1**: return all
 */
- (NSArray *)getBrownBagLists:(NSInteger)status;

/**
 Create a new brown bag. You need to pass the brown bag information.
 
 @param topic The topic name. For example: **TEA**
 @param scheduledDate The scheduled presentation date. This is optional.
 @param speader The speaker's name. This is optional
 @param description Describe what is topic about. This is optional.

 @return If create success, return the id of this new brown bag, otherwise it will return `-1`
 
 */
- (NSInteger)createABrownBag:(NSString *)topic scheduledDate:(NSInteger)scheduledDate speaker:(NSString *)speader description:(NSString *)description;

/**
 Get a brown bag's information, you must pass the brown bag ID.
 
 @param brownBagID The ID of query brown bag
 
 @return If get success, retuan a NSDictionary contains this brown bag's information.
 
 ```
{
    id: 1,
    topic: "AnagularJS Localization",
    scheduledDate: 12345678,
    speaker: "Shaoke Xu",
    description: "Introduce how to do localization in AngularJS Project",
    finishedDate: NULL,
    signatureImagesPath: "/2014_12_25_AngularJS_Localization",
    signaturePdfPath: NULL,
    attendPeopleNumber:0
 }
 ```
 
 otherwise return `NULL`
 */
- (NSDictionary *)getABrownBag:(NSInteger)brownBagID;

/**
 Update a brown bag. Update the field that you passed
 
 @param brownBagItems This NSDictionary contains all the items that need to update. You just need to pass the items that you want to update. You must pass `id`.
 
 ```
 {
    id: 1,
    topic: "AnagularJS Localization",
    scheduledDate: 12345678,
    speaker: "Shaoke Xu",
    description: "Introduce how to do localization in AngularJS Project",
    finishedDate: NULL,
    signatureImagesPath: "/2014_12_25_AngularJS_Localization",
    signaturePdfPath: NULL,
    attendPeopleNumber:0
 }
 ```
 
 @return If update success, return brown bag id, otherwise return `NULL`
 
 */
- (NSInteger)updateABrownBag:(NSDictionary *)brownBagItems;

/**
 Delete a brown bag. Delete a brown bag will delete all information about this brown bag, includes signature images if it has.
 
 @param brownBagID The ID of delete brown bag
 
 @return If delete successful, it will return `YES`, otherwise it will return `NO`
 */
- (BOOL)deleteABrownBag:(NSInteger)brownBagID;


/** signature_images table **/
- (NSDictionary *)getSignatureImagesByBrownBag:(NSDictionary *)brownBagID;

- (NSDictionary *)createASignature:(NSDictionary *)signatureInfo;

- (NSDictionary *)getASignature:(NSDictionary *)signatureID;

- (NSDictionary *)updateASignature:(NSDictionary *)signatureInfo;

- (NSDictionary *)deleteASignature:(NSDictionary *)signatureID;

@end
