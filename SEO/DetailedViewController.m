//
//  DetailedViewController.m
//  SEO
//
//  Created by Jamie Hands on 2/24/14.
//  Copyright (c) 2014 Chameleon. All rights reserved.
//

#import "DetailedViewController.h"
#import "TFHpple.h"
#import "H1.h"
#import "H2.h"
#import "H3.h"
#import "Image.h"
#import "AppFunctions.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadImages {
    NSURL *imagesUrl = [NSURL URLWithString:self.url];
    NSData *imagesHTMLData = [NSData dataWithContentsOfURL:imagesUrl];
    TFHpple *imagesParser = [TFHpple hppleWithHTMLData:imagesHTMLData];
    NSString *imagesXpathQueryString = @"//img";
    NSArray *imagesNodes = [imagesParser searchWithXPathQuery:imagesXpathQueryString];
    NSMutableArray *newImages = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in imagesNodes) {
        Image *image = [[Image alloc] init];
        [newImages addObject:image];
        image.path = [element objectForKey:@"src"];
        image.alt = [element objectForKey:@"alt"];
    }
    _objects = newImages;
    [self.tableView reloadData];
}

- (void)loadH1 {
    NSURL *h1Url = [NSURL URLWithString:self.url];
    NSData *h1HTMLData = [NSData dataWithContentsOfURL:h1Url];
    TFHpple *h1Parser = [TFHpple hppleWithHTMLData:h1HTMLData];
    NSString *h1XpathQueryString = @"//h1";
    NSArray *h1Nodes = [h1Parser searchWithXPathQuery:h1XpathQueryString];
    NSMutableArray *newH1 = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in h1Nodes) {
        H1 *h1 = [[H1 alloc] init];
        [newH1 addObject:h1];
        h1.H1 = @"H1";
        h1.value = [[element firstChild] content];
    }
    _header1 = newH1;
    [self.tableView reloadData];
}

- (void)loadH2 {
    NSURL *h2Url = [NSURL URLWithString:self.url];
    NSData *h2HTMLData = [NSData dataWithContentsOfURL:h2Url];
    TFHpple *h2Parser = [TFHpple hppleWithHTMLData:h2HTMLData];
    NSString *h2XpathQueryString = @"//h2";
    NSArray *h2Nodes = [h2Parser searchWithXPathQuery:h2XpathQueryString];
    NSMutableArray *newH2 = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in h2Nodes) {
        H2 *h2 = [[H2 alloc] init];
        [newH2 addObject:h2];
        h2.H2 = @"H2";
        h2.value = [[element firstChild] content];
    }
    _header2 = newH2;
    [self.tableView reloadData];
}

- (void)loadH3 {
    NSURL *h3Url = [NSURL URLWithString:self.url];
    NSData *h3HTMLData = [NSData dataWithContentsOfURL:h3Url];
    TFHpple *h3Parser = [TFHpple hppleWithHTMLData:h3HTMLData];
    NSString *h3XpathQueryString = @"//h3";
    NSArray *h3Nodes = [h3Parser searchWithXPathQuery:h3XpathQueryString];
    NSMutableArray *newH3 = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in h3Nodes) {
        H3 *h3 = [[H3 alloc] init];
        [newH3 addObject:h3];
        h3.H3 = @"H3";
        h3.value = [[element firstChild] content];
    }
    _header3 = newH3;
    [self.tableView reloadData];
}

- (IBAction)buttonBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.labelURL.text = self.url;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if([self.selected isEqualToString:@"images"]) {
        [self loadImages];
    } else if([self.selected isEqualToString:@"headings"]){
        [self loadH1];
        [self loadH2];
        [self loadH3];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.selected isEqualToString:@"robots"]) {
        return 1;
    } else if([self.selected isEqualToString:@"sitemap"]) {
        return 1;
    } else if([self.selected isEqualToString:@"metadata"]) {
        return 3;
    } else if([self.selected isEqualToString:@"images"]) {
        return 1;
    } else if([self.selected isEqualToString:@"headings"]){
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.selected isEqualToString:@"robots"]) {
        return 1;
    } else if([self.selected isEqualToString:@"sitemap"]) {
        return 1;
    } else if([self.selected isEqualToString:@"metadata"]) {
        return 1;
    } else if([self.selected isEqualToString:@"images"]) {
        return _objects.count;
    } else if([self.selected isEqualToString:@"headings"]) {
        switch (section) {
            case 0:
                return _header1.count;
                break;
            case 1:
                return _header2.count;
                break;
            case 2:
                return _header3.count;
                break;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if([self.selected isEqualToString:@"robots"]) {
        AppFunctions *Functions = [[AppFunctions alloc] init];
        if([Functions CheckRobots:self.url]==FALSE) {
            cell.textLabel.text = @"Robots.txt";
        } else {
            cell.textLabel.text = @"Robots.txt";
            cell.detailTextLabel.text = @"Found";
        }
    } else if([self.selected isEqualToString:@"sitemap"]) {
        AppFunctions *Functions = [[AppFunctions alloc] init];
        if([Functions CheckSitemap:self.url]==FALSE) {
            cell.textLabel.text = @"Sitemap.xml";
        } else {
            cell.textLabel.text = @"Sitemap.xml";
            cell.detailTextLabel.text = @"Found";
        }
    } else if([self.selected isEqualToString:@"metadata"]) {
        AppFunctions *Functions = [[AppFunctions alloc] init];
        if(indexPath.section == 0) {
            cell.textLabel.text = @"Title";
            cell.detailTextLabel.text = [Functions FetchTitle:self.url];
        } else if(indexPath.section == 1) {
            cell.textLabel.text = @"Meta Keywords";
            cell.detailTextLabel.text = [Functions FetchMetaKeywords:self.url];
        } else if(indexPath.section == 2) {
            cell.textLabel.text = @"Meta Description";
            cell.detailTextLabel.text = [Functions FetchMetaDescription:self.url];
        }
        
    } else if([self.selected isEqualToString:@"images"]) {
        Image *thisImage = [_objects objectAtIndex:indexPath.row];
        cell.textLabel.text = thisImage.path;
        cell.detailTextLabel.text = thisImage.alt;
    } else if([self.selected isEqualToString:@"headings"]){
        if(indexPath.section == 0) {
            H1 *thisH1 = [_header1 objectAtIndex:indexPath.row];
            cell.textLabel.text = thisH1.H1;
            cell.detailTextLabel.text = thisH1.Value;
        } else if(indexPath.section == 1) {
            H2 *thisH2 = [_header2 objectAtIndex:indexPath.row];
            cell.textLabel.text = thisH2.H2;
            cell.detailTextLabel.text = thisH2.Value;
        } else if(indexPath.section == 2) {
            H3 *thisH3 = [_header3 objectAtIndex:indexPath.row];
            cell.textLabel.text = thisH3.H3;
            cell.detailTextLabel.text = thisH3.Value;
        }
    }
    if(cell.detailTextLabel.text == nil) {
        cell.imageView.image = [UIImage imageNamed:@"red_cog"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"green_cog"];
    }
    return cell;
}

@end
