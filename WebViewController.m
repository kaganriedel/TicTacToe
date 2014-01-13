//
//  WebViewController.m
//  TicTacToe
//
//  Created by Kagan Riedel on 1/12/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UITextField *myURLTextField;
    __weak IBOutlet UIWebView *myWebView;
    __weak IBOutlet UILabel *label;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
}

@end

@implementation WebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	myWebView.scrollView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/Tic-tac-toe"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSURL *url = [NSURL URLWithString:myURLTextField.text];
    NSRange isRange = [myURLTextField.text rangeOfString:@"http://" options:NSCaseInsensitiveSearch];
    if (isRange.location == NSNotFound) {
        NSString *string = [NSString stringWithFormat:@"http://%@", myURLTextField.text];
        url = [NSURL URLWithString:string];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
    [myURLTextField resignFirstResponder];
    return YES;
}

- (IBAction)onBackButtonPressed:(id)sender
{
    [myWebView goBack];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    [myWebView goForward];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender
{
    [myWebView reload];
}

- (IBAction)onPlusButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Coming soon!" delegate:nil cancelButtonTitle:@"That's Chill" otherButtonTitles: nil];
    [alert show];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    myURLTextField.alpha = 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    myURLTextField.alpha = 1;
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    NSURL *url = aWebView.request.mainDocumentURL;
    myURLTextField.text = [NSString stringWithFormat:@"%@",url];
    NSString *title = [aWebView stringByEvaluatingJavaScriptFromString: @"document.title"];
    label.text = title;
    [activityIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
