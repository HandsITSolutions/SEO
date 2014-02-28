//
//  ViewController.m
//  SEO
//
//  Created by Jamie Hands on 21/02/2014.
//  Copyright (c) 2014 Chameleon. All rights reserved.
//

#import "StartViewController.h"
#import "SummaryViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController
@synthesize textURL;

- (IBAction)textFieldReturn:(id)sender {
    // Hide the Keyboard
    [sender resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"summary"]) {
        SummaryViewController *summary = (SummaryViewController *)segue.destinationViewController;
        if([self.textURL.text hasPrefix:@"http://"] == YES) {
            summary.url = self.textURL.text;
        } else {
            summary.url = [NSString stringWithFormat:@"%@%@",@"http://",self.textURL.text];
        }
        [self.loading stopAnimating];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    self.view.center = CGPointMake(self.originalCentre.x-160,self.originalCentre.y);
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    self.view.center = self.originalCentre;
}

- (IBAction)buttonGo:(id)sender {
    [self.loading startAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    self.originalCentre = self.view.center;
    self.loading.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"o2"],[UIImage imageNamed:@"o3"], [UIImage imageNamed:@"o4"], [UIImage imageNamed:@"o1"],nil];
    self.loading.animationDuration = 0.25;
    self.loading.animationRepeatCount = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
