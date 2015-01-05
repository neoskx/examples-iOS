//
//  BrownBag.h
//  Signature
//
//  Created by Shaoke Xu on 1/3/15.
//  Copyright (c) 2015 Shaoke Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrownBag : NSObject

@property(nonatomic) NSInteger ID;
@property(nonatomic) NSString *topic;
@property(nonatomic) NSDate *scheduledDate;
@property(nonatomic) NSInteger status;
@property(nonatomic) NSDate *createdDate;
@property(nonatomic) NSString *speaker;
@property(nonatomic) NSString *topicDescription;
@property(nonatomic) NSDate *finishedDate;
@property(nonatomic) NSString *signatureImagesPath;
@property(nonatomic) NSString *signaturePdfPath;
@property(nonatomic) NSInteger attendPeopleNumber;

@end
