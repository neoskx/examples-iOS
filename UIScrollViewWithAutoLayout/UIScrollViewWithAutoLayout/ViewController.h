//
//  ViewController.h
//  UIScrollViewWithAutoLayout
//
//  Created by Shaoke Xu on 12/28/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void) keyboardWillBeHidden:(NSNotification *)notification;
- (void) keyboardDidShow:(NSNotification *)notification;

@end

