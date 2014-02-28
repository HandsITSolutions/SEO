//
//  ViewController.h
//  SEO
//
//  Created by Jamie Hands on 21/02/2014.
//  Copyright (c) 2014 Chameleon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController {
    UITextField *textURL;
}

@property CGPoint originalCentre;
@property (weak, nonatomic) IBOutlet UIImageView *loading;
@property (nonatomic, retain) IBOutlet UITextField *textURL;
- (IBAction)textFieldReturn:(id)sender;
@end
