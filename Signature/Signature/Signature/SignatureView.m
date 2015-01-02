//
//  SignatureView.m
//  Signature
//
//  Created by Shaoke Xu on 12/27/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import "SignatureView.h"

@interface SignatureView(){
    UIBezierPath *path;
}

@end

@implementation SignatureView

- (void)commonInit {
    path = [UIBezierPath bezierPath];
    
    // Capture touches
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
    
    //Erase with long press
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(erase)]];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) [self commonInit];
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) [self commonInit];
    return self;
}

- (void)erase {
    path = [UIBezierPath bezierPath];
    [self setNeedsDisplay];
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint currentPoint = [pan locationInView:self];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        [path moveToPoint:currentPoint];
    } else if (pan.state == UIGestureRecognizerStateChanged)
        [path addLineToPoint:currentPoint];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    [path stroke];
}

- (void)generateImage{
    //hide controls if needed
    CGRect rect = [self bounds];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];
    
    // Save image.
    [UIImagePNGRepresentation(img) writeToFile:filePath atomically:YES];
}

@end
