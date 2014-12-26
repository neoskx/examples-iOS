//
//  ToDoListTableTableViewController.m
//  ToDoList
//
//  Created by Shaoke Xu on 12/24/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import "ToDoListTableTableViewController.h"
#import "AddToDoItemViewController.h"
#import "ToDoItemData.h"

@interface ToDoListTableTableViewController ()

@end

@implementation ToDoListTableTableViewController

- (void)viewDidLoad {
    [self loadData];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadData{
    self.toDoItemList = [[NSMutableArray alloc] init];
    [self.toDoItemList addObject: [[ToDoItemData alloc] initWithSubject:@"Buy Milk" ]];
    [self.toDoItemList addObject: [[ToDoItemData alloc] initWithSubject:@"Call Ananta" ]];
    [self.toDoItemList addObject: [[ToDoItemData alloc] initWithSubject:@"Read Book" ]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToDoList:(UIStoryboardSegue *)sender{
    NSLog(@"unwindToDoList");
    AddToDoItemViewController *addToDoItemVC = [sender sourceViewController];
    if (addToDoItemVC.toDoItem != nil) {
        [self.toDoItemList addObject:addToDoItemVC.toDoItem];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.toDoItemList count];
}

/* */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toDoItemCell" forIndexPath:indexPath];
    
    // Configure the cell...
    ToDoItemData *item = [self.toDoItemList objectAtIndex:indexPath.row];
    cell.textLabel.text = item.subject;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
