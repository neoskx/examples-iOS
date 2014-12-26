//
//  AddToDoItemViewController.h
//  ToDoList
//
//  Created by Shaoke Xu on 12/24/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToDoItemData;

@interface AddToDoItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *toDoSubject;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property ToDoItemData* toDoItem;

@end
