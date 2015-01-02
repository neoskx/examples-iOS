//
//  ViewController.h
//  Signature
//
//  Created by Shaoke Xu on 12/26/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignatureView;

@interface ViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet SignatureView *signatureView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *bkButton;

- (IBAction)save:(id)sender;
- (IBAction)reset:(id)sender;

- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardDidHide:(NSNotification *)notification;
- (IBAction)hideKeyboard:(id)sender;

@end

