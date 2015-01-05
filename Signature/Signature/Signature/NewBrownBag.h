//
//  NewBrownBag.h
//  Signature
//
//  Created by Shaoke Xu on 1/2/15.
//  Copyright (c) 2015 Shaoke Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewBrownBag : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *topicName;
@property (weak, nonatomic) IBOutlet UITextField *speakerName;
@property (weak, nonatomic) IBOutlet UITextField *scheduleDate;
@property (weak, nonatomic) IBOutlet UITextView *topicDescription;
@property(nonatomic) UIAlertView *alertView;

/**
 Save brown bag information
 */
- (void)save;

- (void)scheduledDateChange:(id)sender;

@end
