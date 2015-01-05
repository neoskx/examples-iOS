//
//  NewBrownBag.m
//  Signature
//
//  Created by Shaoke Xu on 1/2/15.
//  Copyright (c) 2015 Shaoke Xu. All rights reserved.
//

#import "NewBrownBag.h"
#import "BrownBag.h"
#import "DBManager.h"

@implementation NewBrownBag

- (void)viewDidLoad{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightBar;
    self.navigationItem.title = @"New Brown Bag";
    
    //when tap schedule date, show date picker
    UIDatePicker *scheduledDate = [[UIDatePicker alloc] init];
    [scheduledDate setDate:[NSDate date]];
    scheduledDate.datePickerMode = UIDatePickerModeDateAndTime;
    [scheduledDate addTarget:self action:@selector(scheduledDateChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.scheduleDate setInputView:scheduledDate];
}

- (void)scheduledDateChange:(id)sender{
    NSLog(@"%@", sender);
    UIDatePicker *scheduledDate = (UIDatePicker *)self.scheduleDate.inputView;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, YYYY HH:mm a"]; // The date should be 'Jan 1, 2015 8:00 am'
    
    // Set selected date to textfield
    self.scheduleDate.text = [formatter stringFromDate:scheduledDate.date];
}

- (void)showAlertView:(NSString *)message{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [self.alertView show];
}


- (void)save{
    if (self.topicName.text.length<=0) {
        [self showAlertView:@"You must input topic name"];
        return;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"MMM dd, YYYY HH:mm a"];
    
    NSInteger brownBagID = [[DBManager getSharedInstance] createABrownBag:self.topicName.text scheduledDate:[[formatter dateFromString:self.scheduleDate.text] timeIntervalSince1970] speaker:self.speakerName.text description:self.topicDescription.text];
    
    if (brownBagID != -1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Didn't save success, please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

@end
