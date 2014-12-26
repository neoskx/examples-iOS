//
//  AddToDoItemViewController.m
//  ToDoList
//
//  Created by Shaoke Xu on 12/24/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import "AddToDoItemViewController.h"
#import "ToDoItemData.h"

@interface AddToDoItemViewController ()

@end

@implementation AddToDoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender != self.saveButton) {
        return;
    }else{
        if (self.toDoSubject.text.length >0) {
            ToDoItemData *toDoItem = [[ToDoItemData alloc] initWithSubject:self.toDoSubject.text];
            self.toDoItem = toDoItem;
        }
    }
}


@end
