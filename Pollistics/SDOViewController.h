//
//  SDOViewController.h
//  Pollistics
//
//  Created by Mark D. Timares on 4/30/13.
//  Copyright (c) 2013 Studiosudo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDOViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *questionLabelOutlet;
@property (weak, nonatomic) IBOutlet UITextView *choice1LabelOutlet;
@property (weak, nonatomic) IBOutlet UITextView *choice2LabelOutlet;
@property (weak, nonatomic) IBOutlet UITextView *choice3LabelOutlet;
@property (weak, nonatomic) IBOutlet UITextView *choice4LabelOutlet;

@property (weak, nonatomic) IBOutlet UILabel *statusLabelOutlet;

- (IBAction)voteAction:(id)sender;
- (IBAction)refreshAction:(id)sender;

@end
