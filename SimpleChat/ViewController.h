//
//  ViewController.h
//  SimpleChat
//
//  Created by AJTech on 9/27/13.
//  Copyright (c) 2015 Ajay Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
        IBOutlet UILabel *label;
    IBOutlet UIImageView *other;

}



-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;

-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;
-(IBAction)Start;

-(void)move;

@end
