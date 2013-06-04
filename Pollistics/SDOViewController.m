//
//  SDOViewController.m
//  Pollistics
//
//  Created by Mark D. Timares on 4/30/13.
//  Copyright (c) 2013 Studiosudo. All rights reserved.
//

#import "SDOViewController.h"

@interface SDOViewController ()




@end

@implementation SDOViewController


bool questionIsSameBool;
NSString * currentQuestionIsString = @"y";
NSString * lastVoteWas = @" ";



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"I am in View Did Load");
    [self refreshAction:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* VOTE METHOD =========================================== */
- (IBAction)voteAction:(id)sender {
    
    NSString * aButtonTitle, * bButtonTitle,* cButtonTitle,* dButtonTitle;
    aButtonTitle =@"A"; bButtonTitle=@"B"; cButtonTitle=@"C"; dButtonTitle=@"D";
    
        NSString * voteButtonTitleString = [sender titleForState:UIControlStateNormal];
    
    
    
    
    UIImage *blueImage = [UIImage imageNamed:@"BlueButtonAi.png"];
    
    [self.button1Outlet setBackgroundImage:blueImage forState:UIControlStateNormal];
    [self.button2Outlet setBackgroundImage:blueImage forState:UIControlStateNormal];
    [self.button3Outlet setBackgroundImage:blueImage forState:UIControlStateNormal];
    [self.button4Outlet setBackgroundImage:blueImage forState:UIControlStateNormal];
    //[sender setTitle:voteButtonTitleString forState:UIControlStateNormal];
    
    
    UIImage *image = [UIImage imageNamed:@"SelectedButtonAi.png"];
    [sender setBackgroundImage:image forState:UIControlStateNormal];
    
    //[sender setTitle:voteButtonTitleString forState:UIControlStateNormal];
    
    NSURL *url;
    
    if (!questionIsSameBool) { // First Time Voting
        NSLog (@"In Not Same Question Block");
        if ([voteButtonTitleString isEqualToString:aButtonTitle])
            url = [ NSURL URLWithString: [ NSString stringWithFormat: @"http://www.pollistics.com?x=a"] ];
        
        else if ([voteButtonTitleString isEqualToString:bButtonTitle]){
            url = [ NSURL URLWithString: [ NSString stringWithFormat: @"http://www.pollistics.com?x=b"] ];
        }
        else if ([voteButtonTitleString isEqualToString:cButtonTitle]){
            url = [ NSURL URLWithString: [ NSString stringWithFormat: @"http://www.pollistics.com?x=c"] ];
            
        }else if ([voteButtonTitleString isEqualToString:dButtonTitle]){
            url = [ NSURL URLWithString: [ NSString stringWithFormat: @"http://www.pollistics.com?x=d"] ];
            
        } else NSLog (@"Vote Button Error, %@", voteButtonTitleString);
    }
    else{ // Revoting
        
        NSLog (@"In Is Same Question Block");
        // Convert the lastVoteWas String to Lower Case for use in URL
        NSString *lastVoteWasLowerCase = [lastVoteWas lowercaseString];
       
        if ([voteButtonTitleString isEqualToString:aButtonTitle]){
            NSString *voteString = @"http://www.pollistics.com?x=a&c=";
            url = [ NSURL URLWithString:[ voteString stringByAppendingString:lastVoteWasLowerCase]];
                                                                           
        }
        else if ([voteButtonTitleString isEqualToString:bButtonTitle]){
            NSString *voteString = @"http://www.pollistics.com?x=b&c=";
            url = [ NSURL URLWithString:[ voteString stringByAppendingString:lastVoteWasLowerCase]];
        }
        else if ([voteButtonTitleString isEqualToString:cButtonTitle]){
            NSString *voteString = @"http://www.pollistics.com?x=c&c=";
            url = [ NSURL URLWithString:[ voteString stringByAppendingString:lastVoteWasLowerCase]];

        }else if ([voteButtonTitleString isEqualToString:dButtonTitle]){
            NSString *voteString = @"http://www.pollistics.com?x=d&c=";
            url = [ NSURL URLWithString:[ voteString stringByAppendingString:lastVoteWasLowerCase]];
        } else NSLog (@"Vote Button Error, %@", voteButtonTitleString);
       
    }
    
    NSLog (@"URL %@", url);
    [NSString stringWithContentsOfURL:url];
    //NSLog (urlText);
    questionIsSameBool = true;
    
    NSString * statusMessageString = @"Voted for ";
    statusMessageString = [statusMessageString stringByAppendingString:voteButtonTitleString];
    
    NSLog(@"%@",statusMessageString);
          
    self.statusLabelOutlet.text = statusMessageString;

    lastVoteWas = voteButtonTitleString;

}




/* REFRESH METHOD =====================================*/
- (IBAction)refreshAction:(id)sender {

    UIImage *blueImage = [UIImage imageNamed:@"BlueButtonAi.png"];

    
    [self.button1Outlet setBackgroundImage:blueImage forState:UIControlStateNormal];
    [self.button2Outlet setBackgroundImage:blueImage forState:UIControlStateNormal];
    [self.button3Outlet setBackgroundImage:blueImage forState:UIControlStateNormal];
    [self.button4Outlet setBackgroundImage:blueImage forState:UIControlStateNormal];

    
    
    // Defines the URL for the Vote

    
    
    
    NSURL *url = [ NSURL URLWithString: [ NSString stringWithFormat: @"http://www.pollistics.com/index.php"] ];
    
    // Executes the Vote and Puts the returned page from the URL into this String
    NSString *urlText = [NSString stringWithContentsOfURL:url];
    
    // Display URL String
    // self.returnedTextLabelOutlet.text = urlText;
    
    // Define Serarch Criteria
    NSString * questionSpanSearchText = @"<span id='question'>";
    NSString * answerASpanSearchText = @"<span id='text_a'>";
    NSString * answerBSpanSearchText = @"<span id='text_b'>";
    NSString * answerCSpanSearchText = @"<span id='text_c'>";
    NSString * answerDSpanSearchText = @"<span id='text_d'>";
    NSString * spanCloseTag = @"</span>";
    
    
    NSRange questionRange; //marks the beginning of the question and it's length
    NSRange textEndRange; // marks the end of the question, and the length of the closing span tag
    NSRange searchRange; // is the beginning of the search range, plus a fixed number like 100
    

    
    
    
// Obtain the Question and Display
    
    questionRange = [urlText rangeOfString:questionSpanSearchText];
    questionRange.location = questionRange.location + questionRange.length;
 
    searchRange = questionRange;
    searchRange.length = 70;
    
    textEndRange = [urlText rangeOfString:spanCloseTag options:NSLiteralSearch range:searchRange];
    
    NSLog(@"QLocation %d",questionRange.location);
    NSLog(@"QLength %d", questionRange.length);
       
    // Get position of question end
        // Set size of question string
    questionRange.length = textEndRange.location - questionRange.location;
    NSLog(@"QLengthAdj %d", questionRange.length);

    NSString * questionText = [urlText substringWithRange:questionRange];
    
    if ([questionText isEqualToString:currentQuestionIsString])
        questionIsSameBool = true;
    else{
        questionIsSameBool = false;
        lastVoteWas = nil;
        self.statusLabelOutlet.text = @"Please Vote";
        
    }
    currentQuestionIsString = questionText;
   
    self.questionLabelOutlet.text = questionText;
       
    // Comment
    // Obtain First Answer Choice and Display        
    NSRange answerARange = [urlText rangeOfString:answerASpanSearchText];
    answerARange.location = answerARange.location + answerARange.length;
    
    searchRange = answerARange;
    searchRange.length = 70;

    textEndRange = [urlText rangeOfString:spanCloseTag options:NSLiteralSearch range:searchRange];
    
    answerARange.length = textEndRange.location - answerARange.location;
    
    NSLog(@"ALocation %d",answerARange.location);
    NSLog(@"ALength %d", answerARange.length);
    
    NSString * answerAText = [urlText substringWithRange:answerARange];
    
    self.choice1LabelOutlet.text = answerAText;
    
    
    
    // Obtain Second Answer Choice and Display
    NSRange answerBRange = [urlText rangeOfString:answerBSpanSearchText];
    answerBRange.location = answerBRange.location + answerBRange.length;
    
    searchRange = answerBRange;
    searchRange.length = 70;
    
    textEndRange = [urlText rangeOfString:spanCloseTag options:NSLiteralSearch range:searchRange];
    
    answerBRange.length = textEndRange.location - answerBRange.location;
    
    NSLog(@"BLocation %d",answerBRange.location);
    NSLog(@"BLength %d", answerBRange.length);
    
    NSString * answerBText = [urlText substringWithRange:answerBRange];
    
    self.choice2LabelOutlet.text = answerBText;


    // Obtain Third Answer Choice and Display
    NSRange answerCRange = [urlText rangeOfString:answerCSpanSearchText];
    answerCRange.location = answerCRange.location + answerCRange.length;
    
    searchRange = answerCRange;
    searchRange.length = 70;
    
    textEndRange = [urlText rangeOfString:spanCloseTag options:NSLiteralSearch range:searchRange];
    
    answerCRange.length = textEndRange.location - answerCRange.location;
    
    NSLog(@"CLocation %d",answerCRange.location);
    NSLog(@"CLength %d", answerCRange.length);
    
    NSString * answerCText = [urlText substringWithRange:answerCRange];
    NSLog(@"CText%@", answerCText);
    
    self.choice3LabelOutlet.text = answerCText;

    
    // Obtain Fourth Answer Choice and Display
    NSRange answerDRange = [urlText rangeOfString:answerDSpanSearchText];
    answerDRange.location = answerDRange.location + answerDRange.length;
    
    searchRange = answerDRange;
    searchRange.length = 70;
    
    textEndRange = [urlText rangeOfString:spanCloseTag options:NSLiteralSearch range:searchRange];
    
    answerDRange.length = textEndRange.location - answerDRange.location;
    
    NSLog(@"DLocation %d",answerDRange.location);
    NSLog(@"DLength %d", answerDRange.length);
    
    NSString * answerDText = [urlText substringWithRange:answerDRange];
    
    self.choice4LabelOutlet.text = answerDText;

    

    


    
    
}
@end
