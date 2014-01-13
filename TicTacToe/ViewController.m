//
//  ViewController.m
//  TicTacToe
//
//  Created by Sonam Mehta on 1/10/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate, UIGestureRecognizerDelegate>
{
    
    __weak IBOutlet UILabel *whichPlayerLabel;
    __weak IBOutlet UILabel *myLabelNine;
    __weak IBOutlet UILabel *myLabelEight;
    __weak IBOutlet UILabel *myLabelSeven;
    __weak IBOutlet UILabel *myLabelSix;
    __weak IBOutlet UILabel *myLabelFive;
    __weak IBOutlet UILabel *myLabelFour;
    __weak IBOutlet UILabel *myLabelThree;
    __weak IBOutlet UILabel *myLabelTwo;
    __weak IBOutlet UILabel *myLabelOne;
    __weak IBOutlet UILabel *markerLabel;
    __weak IBOutlet UILabel *timerLabel;
    CGAffineTransform transform;
    NSInteger counter;
    NSTimer *timer;
}


@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    transform = markerLabel.transform;
    [self startCountdown];
}

- (void)startCountdown
{
    counter = 10;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(countdownTimer:)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)countdownTimer:(NSTimer *)timer
{
    counter--;
    timerLabel.text = [NSString stringWithFormat:@"%i", counter];
    
    if (counter <= 0) {
        //[timer invalidate];
        //  Here the counter is 0 and you can take call another method to take action
        [self handleCountdownFinished];
    }
}

-(void) handleCountdownFinished
{
    [self switchPlayer];
}

-(IBAction)onDrag:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (CGRectContainsPoint(markerLabel.frame, [panGestureRecognizer locationInView:self.view])) {
        
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        UILabel *label = [self findLabelUsingPoint:[panGestureRecognizer locationInView:self.view]];
        if (label != nil)
        {
            label.text = markerLabel.text;
            label.textColor = markerLabel.textColor;
            NSString *winner = [self whoOne];
            if ([winner isEqualToString:@"X"] == YES || [winner isEqualToString:@"O"] == YES) {
                if ([winner isEqualToString:@"X"] == YES) {
                    winner = @"Player 1 is the winner!";
                }
                if ([winner isEqualToString:@"O"] == YES) {
                    winner = @"Player 2 is the winner!";
                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Winner!" message:winner delegate:self cancelButtonTitle:@"New Game" otherButtonTitles: nil];
                [alert show];
                [self alertView:alert clickedButtonAtIndex:1];
                
            }
            [self switchPlayer];

        
        [UIView animateWithDuration:0.5f animations:^{markerLabel.transform = transform;}];
        }
    }
    else {
        
        CGPoint point = [panGestureRecognizer translationInView:self.view];
        markerLabel.transform = CGAffineTransformMakeTranslation(point.x, point.y);
        point.x += markerLabel.center.x;
        point.y += markerLabel.center.y;
        
        }
    }
}

-(UILabel *)findLabelUsingPoint:(CGPoint)point
{
    if (CGRectContainsPoint(myLabelOne.frame, point)) {
        if ([myLabelOne.text isEqualToString:@"X"] == NO && [myLabelOne.text isEqualToString:@"O"] == NO) {
            return myLabelOne;
            }
    }
    if (CGRectContainsPoint(myLabelTwo.frame, point)) {
        if ([myLabelTwo.text isEqualToString:@"X"] == NO && [myLabelTwo.text isEqualToString:@"O"] == NO) {
            return myLabelTwo;
        }
    }
    if (CGRectContainsPoint(myLabelThree.frame, point)) {
        if ([myLabelThree.text isEqualToString:@"X"] == NO && [myLabelThree.text isEqualToString:@"O"] == NO) {
            return myLabelThree;
        }
    }
    if (CGRectContainsPoint(myLabelFour.frame, point)) {
        if ([myLabelFour.text isEqualToString:@"X"] == NO && [myLabelFour.text isEqualToString:@"O"] == NO) {
            return myLabelFour;
        }
    }
    if (CGRectContainsPoint(myLabelFive.frame, point)) {
        if ([myLabelFive.text isEqualToString:@"X"] == NO && [myLabelFive.text isEqualToString:@"O"] == NO) {
            return myLabelFive;
        }
    }
    if (CGRectContainsPoint(myLabelSix.frame, point)) {
        if ([myLabelSix.text isEqualToString:@"X"] == NO && [myLabelSix.text isEqualToString:@"O"] == NO) {
            return myLabelSix;
        }
    }
    if (CGRectContainsPoint(myLabelSeven.frame, point)) {
        if ([myLabelSeven.text isEqualToString:@"X"] == NO && [myLabelSeven.text isEqualToString:@"O"] == NO) {
            return myLabelSeven;
        }
    }
    if (CGRectContainsPoint(myLabelEight.frame, point)) {
        if ([myLabelEight.text isEqualToString:@"X"] == NO && [myLabelEight.text isEqualToString:@"O"] == NO) {
            return myLabelEight;
        }
    }
    if (CGRectContainsPoint(myLabelNine.frame, point)) {
        if ([myLabelNine.text isEqualToString:@"X"] == NO && [myLabelNine.text isEqualToString:@"O"] == NO) {
            return myLabelNine;
        }
    }
    return nil;
}

-(NSString *)whoOne
{
    NSString *whoOne = [self checkLabelsForWinner];
    if (whoOne != nil) {
        return whoOne;
    }
    return nil;
}

-(NSString *)checkLabelsForWinner
{
    if ([myLabelOne.text isEqualToString:@"Ω"]== NO && [myLabelOne.text isEqualToString:myLabelTwo.text]== YES && [myLabelTwo.text isEqualToString:myLabelThree.text] ==YES)
    {
        return myLabelOne.text;
    }
    if ([myLabelFour.text isEqualToString:@"Ω"]== NO &&[myLabelFour.text isEqualToString:myLabelFive.text]== YES && [myLabelFive.text isEqualToString:myLabelSix.text] ==YES)
    {
        return myLabelFive.text;
    }
    if ([myLabelSeven.text isEqualToString:@"Ω"]== NO &&[myLabelSeven.text isEqualToString:myLabelEight.text]== YES && [myLabelEight.text isEqualToString:myLabelNine.text] ==YES)
    {
        return myLabelSeven.text;
    }
    if ([myLabelOne.text isEqualToString:@"Ω"]== NO &&[myLabelOne.text isEqualToString:myLabelFour.text]== YES && [myLabelFour.text isEqualToString:myLabelSeven.text] ==YES)
    {
        return myLabelFour.text;
    }
    if ([myLabelTwo.text isEqualToString:@"Ω"]== NO &&[myLabelTwo.text isEqualToString:myLabelFive.text]== YES && [myLabelFive.text isEqualToString:myLabelEight.text] ==YES)
    {
        return myLabelFive.text;
    }
    if ([myLabelThree.text isEqualToString:@"Ω"]== NO &&[myLabelThree.text isEqualToString:myLabelSix.text]== YES && [myLabelSix.text isEqualToString:myLabelNine.text] ==YES)
    {
        return myLabelThree.text;
    }
    if ([myLabelFive.text isEqualToString:@"Ω"]== NO &&[myLabelOne.text isEqualToString:myLabelFive.text]== YES && [myLabelFive.text isEqualToString:myLabelNine.text] ==YES)
    {
        return myLabelNine.text;
    }
    if ([myLabelThree.text isEqualToString:@"Ω"]== NO &&[myLabelThree.text isEqualToString:myLabelFive.text]== YES && [myLabelFive.text isEqualToString:myLabelSeven.text] ==YES)
    {
        return myLabelSeven.text;
    }
    return nil;
}



- (void) switchPlayer
{
    if ([whichPlayerLabel.text isEqualToString:@"Player 1"] == YES) {
        whichPlayerLabel.text = @"Player 2";
        whichPlayerLabel.textColor = [UIColor blueColor];
        markerLabel.text = @"O";
        markerLabel.textColor = [UIColor blueColor];
    }
    else{
        whichPlayerLabel.text = @"Player 1";
        whichPlayerLabel.textColor = [UIColor redColor];
        markerLabel.text = @"X";
        markerLabel.textColor = [UIColor redColor];
    }
    counter = 10;
    timerLabel.text = [NSString stringWithFormat:@"%i", counter];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self newGame];
    }
}

- (IBAction)onNewGameButtonPressed:(id)sender
{
    [self newGame];
}

-(void) newGame
{
    myLabelOne.text = @"Ω";
    myLabelOne.textColor = [UIColor blackColor];
    myLabelTwo.text = @"Ω";
    myLabelTwo.textColor = [UIColor blackColor];
    myLabelThree.text = @"Ω";
    myLabelThree.textColor = [UIColor blackColor];
    myLabelFour.text = @"Ω";
    myLabelFour.textColor = [UIColor blackColor];
    myLabelFive.text = @"Ω";
    myLabelFive.textColor = [UIColor blackColor];
    myLabelSix.text = @"Ω";
    myLabelSix.textColor = [UIColor blackColor];
    myLabelSeven.text = @"Ω";
    myLabelSeven.textColor = [UIColor blackColor];
    myLabelEight.text = @"Ω";
    myLabelEight.textColor = [UIColor blackColor];
    myLabelNine.text = @"Ω";
    myLabelNine.textColor = [UIColor blackColor];
    counter = 10;
    timerLabel.text = [NSString stringWithFormat:@"%i", counter];
    whichPlayerLabel.text = @"Player 1";
    whichPlayerLabel.textColor = [UIColor redColor];
    markerLabel.text = @"X";
    markerLabel.textColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
