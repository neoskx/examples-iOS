//
//  ViewController.m
//  Signature
//
//  Created by Shaoke Xu on 12/26/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import "ViewController.h"
#import "SignatureView.h"

@interface ViewController ()
@property UITextField *activeField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    if (self.nameTextField.text.length==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                   message:@"Please input your name!"
                                  delegate:self
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alertView show];
        return;
    }
    [self.signatureView generateImage];
}

- (IBAction)reset:(id)sender {
    [self.signatureView erase];
    self.nameTextField.text = nil;
}

- (void)keyboardDidShow:(NSNotification *)notification{
    
    // show the backgroud button, so when use touch, keyboard will disappear
    self.bkButton.hidden = NO;
    
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
    self.scrollView.contentInset = inset;
    self.scrollView.scrollIndicatorInsets = inset;
    
}

- (void)keyboardDidHide:(NSNotification *)notification{
    
    // after keyboard disappear, should hide bkButton
    self.bkButton.hidden = YES;
    
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (IBAction)hideKeyboard:(id)sender{
    [self.activeField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeField = textField;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
