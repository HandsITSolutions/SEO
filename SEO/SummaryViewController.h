//
//  SummaryViewController.h
//  SEO
//
//  Created by Jamie Hands on 23/02/2014.
//  Copyright (c) 2014 Chameleon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryViewController : UIViewController {
    int metaErrors;
    NSString *urlTitle;
    NSString *urlKeywords;
    NSString *urlDescription;
    int imageErrors;
    int headingCount;
}

@property (weak, nonatomic) IBOutlet UILabel *labelURL;
@property (weak, nonatomic) NSString *url;

@property (weak, nonatomic) IBOutlet UIImageView *imgMetadata;
@property (weak, nonatomic) IBOutlet UIImageView *imgImages;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeadings;
@property (weak, nonatomic) IBOutlet UIImageView *imgSitemap;
@property (weak, nonatomic) IBOutlet UIImageView *imgRobots;
@property (weak, nonatomic) IBOutlet UIImageView *loading;
@property (weak, nonatomic) IBOutlet UILabel *labelRobotError;
@property (weak, nonatomic) IBOutlet UILabel *labelSitemapError;
@property (weak, nonatomic) IBOutlet UILabel *labelMetadataError;
@property (weak, nonatomic) IBOutlet UILabel *labelImageError;
@property (weak, nonatomic) IBOutlet UILabel *labelHeadingError;

@end
