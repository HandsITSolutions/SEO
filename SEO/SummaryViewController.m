//
//  SummaryViewController.m
//  SEO
//
//  Created by Jamie Hands on 23/02/2014.
//  Copyright (c) 2014 Chameleon. All rights reserved.
//

#import "SummaryViewController.h"
#import "DetailedViewController.h"
#import "AppFunctions.h"

@interface SummaryViewController ()

@end

@implementation SummaryViewController
@synthesize labelURL;
@synthesize url;
@synthesize imgHeadings;
@synthesize imgImages;
@synthesize imgMetadata;
@synthesize imgRobots;
@synthesize imgSitemap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"robots"]) {
        DetailedViewController *detailed = (DetailedViewController *)segue.destinationViewController;
        detailed.url = self.labelURL.text;
        detailed.selected = @"robots";
    } else if([segue.identifier isEqualToString:@"sitemap"]) {
        DetailedViewController *detailed = (DetailedViewController *)segue.destinationViewController;
        detailed.url = self.labelURL.text;
        detailed.selected = @"sitemap";
    } else if([segue.identifier isEqualToString:@"metadata"]) {
        DetailedViewController *detailed = (DetailedViewController *)segue.destinationViewController;
        detailed.url = self.labelURL.text;
        detailed.selected = @"metadata";
    } else if([segue.identifier isEqualToString:@"images"]) {
        DetailedViewController *detailed = (DetailedViewController *)segue.destinationViewController;
        detailed.url = self.labelURL.text;
        detailed.selected = @"images";
    } else if([segue.identifier isEqualToString:@"headings"]) {
        DetailedViewController *detailed = (DetailedViewController *)segue.destinationViewController;
        detailed.url = self.labelURL.text;
        detailed.selected = @"headings";
    }
    [self.loading stopAnimating];
}

- (IBAction)buttonBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)animateRobots:(id)sender {
    [self.loading startAnimating];
}

- (IBAction)animateSitemap:(id)sender {
    [self.loading startAnimating];
}

- (IBAction)animateMeta:(id)sender {
    [self.loading startAnimating];
}

- (IBAction)animateImages:(id)sender {
    [self.loading startAnimating];
}

- (IBAction)animateHeadings:(id)sender {
    [self.loading startAnimating];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Assign URL to the URL label
    self.labelURL.text = url;
    
    self.loading.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"o2"],[UIImage imageNamed:@"o3"], [UIImage imageNamed:@"o4"], [UIImage imageNamed:@"o1"],nil];
    self.loading.animationDuration = 0.25;
    self.loading.animationRepeatCount = 0;
    
    // Create instance of functions
    AppFunctions *Functions = [[AppFunctions alloc] init];
    
    // Check & Update Robots Cog
    if([Functions CheckRobots:url] == true) {
        self.labelRobotError.text = @"0 ERROR(S)";
        self.labelRobotError.textColor = [UIColor colorWithRed:39/255.0f green:174/255.0f blue:96/255.0f alpha:255];
        imgRobots.image = [UIImage imageNamed:@"green_cog"];
    } else {
        self.labelRobotError.text = @"1 ERROR(S)";
        self.labelRobotError.textColor = [UIColor colorWithRed:255/255.0f green:83/255.0f blue:77/255.0f alpha:255];
        imgRobots.image = [UIImage imageNamed:@"red_cog"];
    }
    
    // Check & Update SiteMap Cog
    if([Functions CheckSitemap:url] == true) {
        self.labelSitemapError.text = @"0 ERROR(S)";
        self.labelSitemapError.textColor = [UIColor colorWithRed:39/255.0f green:174/255.0f blue:96/255.0f alpha:255];
        imgSitemap.image = [UIImage imageNamed:@"green_cog"];
    } else {
        self.labelSitemapError.text = @"1 ERROR(S)";
        self.labelSitemapError.textColor = [UIColor colorWithRed:255/255.0f green:83/255.0f blue:77/255.0f alpha:255];
        imgSitemap.image = [UIImage imageNamed:@"red_cog"];
    }
    
    // Check Title
    urlTitle = [Functions FetchTitle:url];
    if(urlTitle.length == 0) {
        metaErrors += 1;
    }
    
    // Check Meta Keywords
    urlKeywords = [Functions FetchMetaKeywords:url];
    if(urlKeywords.length == 0) metaErrors += 1;

    // Check Meta Description
    urlDescription = [Functions FetchMetaDescription:url];
    if(urlDescription.length == 0) metaErrors += 1;
    
    // Update Meta Cog
    if(metaErrors == 0) {
        self.labelMetadataError.text = @"0 ERROR(S)";
        self.labelMetadataError.textColor = [UIColor colorWithRed:39/255.0f green:174/255.0f blue:96/255.0f alpha:255];
        imgMetadata.image = [UIImage imageNamed:@"green_cog"];
    } else if(metaErrors == 3) {
        self.labelMetadataError.text = [NSString stringWithFormat:@"%d %@",metaErrors,@" ERROR(S)"];
        self.labelMetadataError.textColor = [UIColor colorWithRed:255/255.0f green:83/255.0f blue:77/255.0f alpha:255];
        imgMetadata.image = [UIImage imageNamed:@"red_cog"];
    } else {
        self.labelMetadataError.text = [NSString stringWithFormat:@"%d %@",metaErrors,@" ERROR(S)"];
        self.labelMetadataError.textColor = [UIColor colorWithRed:252/255.0f green:136/255.0f blue:15/255.0f alpha:255];
        imgMetadata.image = [UIImage imageNamed:@"orange_cog"];
    }
    
    // Update & Check Images Cog
    imageErrors = [Functions CountImages:url] - [Functions CountAlt:url];
    if(imageErrors == 0) {
        self.labelImageError.text = @"0 ERROR(S)";
        self.labelImageError.textColor = [UIColor colorWithRed:39/255.0f green:174/255.0f blue:96/255.0f alpha:255];
        imgImages.image = [UIImage imageNamed:@"green_cog"];
    } else {
        self.labelImageError.text = [NSString stringWithFormat:@"%d %@",imageErrors,@" ERROR(S)"];
        self.labelImageError.textColor = [UIColor colorWithRed:252/255.0f green:136/255.0f blue:15/255.0f alpha:255];
        imgImages.image = [UIImage imageNamed:@"orange_cog"];
    }
    
    // Update & Check Headings Cog
    headingCount = [Functions CountH1Tags:url] + [Functions CountH2Tags:url] + [Functions CountH3Tags:url];
    if([Functions CountH1Tags:url] > 0 && [Functions CountH2Tags:url] > 0 && [Functions CountH3Tags:url] > 0) {
        self.labelHeadingError.text = [NSString stringWithFormat:@"%d %@",headingCount,@" HEADING(S)"];
        self.labelHeadingError.textColor = [UIColor colorWithRed:39/255.0f green:174/255.0f blue:96/255.0f alpha:255];
        imgHeadings.image = [UIImage imageNamed:@"green_cog"];
    } else if([Functions CountH1Tags:url] > 0 || [Functions CountH2Tags:url] > 0 || [Functions CountH3Tags:url] > 0) {
        self.labelHeadingError.text = [NSString stringWithFormat:@"%d %@",headingCount,@" HEADING(S)"];
        self.labelHeadingError.textColor = [UIColor colorWithRed:252/255.0f green:136/255.0f blue:15/255.0f alpha:255];
        imgHeadings.image = [UIImage imageNamed:@"orange_cog"];
    } else {
        self.labelHeadingError.text = [NSString stringWithFormat:@"%d %@",headingCount,@" HEADING(S)"];
        self.labelHeadingError.textColor = [UIColor colorWithRed:255/255.0f green:83/255.0f blue:77/255.0f alpha:255];
        imgHeadings.image = [UIImage imageNamed:@"red_cog"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
