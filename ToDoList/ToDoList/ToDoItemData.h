//
//  ToDoItem.h
//  ToDoList
//
//  Created by Shaoke Xu on 12/26/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItemData : NSObject

@property NSString *subject;
@property BOOL completed;
@property(readonly) NSDate *creationDate;

- (id)initWithSubject:(NSString *)subject;
-(void)markItAsCompleted:(BOOL)completed completionDate:(NSDate *)completionDate;

@end
