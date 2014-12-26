//
//  ToDoListTableTableViewController.h
//  ToDoList
//
//  Created by Shaoke Xu on 12/24/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoListTableTableViewController : UITableViewController

@property NSMutableArray *toDoItemList;

-(IBAction)unwindToDoList:(UIStoryboardSegue *)sender;
-(void)loadData;

@end
