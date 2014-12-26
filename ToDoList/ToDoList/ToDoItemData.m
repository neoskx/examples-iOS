//
//  ToDoItem.m
//  ToDoList
//
//  Created by Shaoke Xu on 12/26/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import "ToDoItemData.h"

@interface ToDoItemData()

@property NSDate *completionDate;

@end

@implementation ToDoItemData

-(id)init{
    if (self = [super init]) {
        self.subject = nil;
        _creationDate = [NSDate date];
        self.completionDate = nil;
        self.completed = false;
    }
    return self;
}

- (id)initWithSubject:(NSString *)subject{
    ToDoItemData *item = [self init];
    item.subject = subject;
    
    return item;
}

-(void)markItAsCompleted:(BOOL)completed completionDate:(NSDate *)completionDate{
    self.completed = completed;
    
    if (completionDate !=nil ) {
        self.completionDate = completionDate;
    }else{
        self.completionDate = [NSDate date];
    }
}

@end
