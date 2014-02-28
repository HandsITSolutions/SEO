//
//  DetailedViewController.h
//  SEO
//
//  Created by Jamie Hands on 2/24/14.
//  Copyright (c) 2014 Chameleon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_objects;
    NSMutableArray *_header1;
    NSMutableArray *_header2;
    NSMutableArray *_header3;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UILabel *labelURL;
@property (weak, nonatomic) NSString *selected;

@end
