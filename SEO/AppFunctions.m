//
//  AppFunctions.m
//  SEO
//
//  Created by Jamie Hands on 2/11/14.
//  Copyright (c) 2014 Chameleon. All rights reserved.
//

#import "AppFunctions.h"
#import "TFHpple.h"

@implementation AppFunctions

//
//Functions for the application
//

// Function to check if the Sitemap file exists on the selected url

-(BOOL)CheckSitemap:(NSString*) url
{
    NSURL *sitemap = [NSURL URLWithString:[url stringByAppendingString:@"/sitemap.xml"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:sitemap];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error] ;
    NSLog(@"statusCode = %d", [response statusCode]);
    if([response statusCode]==404) {
        return NO;
    } else {
        return YES;
    }
}

// Function to check if the Robots file exists on the selected url

-(BOOL)CheckRobots:(NSString*) url
{
    NSURL *robots = [NSURL URLWithString:[url stringByAppendingString:@"/robots.txt"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:robots];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error] ;
    NSLog(@"statusCode = %d", [response statusCode]);
    if([response statusCode]==404) {
        return NO;
    } else {
        return YES;
    }
}

// Function to return the title of the selected url

-(NSString*)FetchTitle:(NSString*) url
{
    NSURL *titleURL = [NSURL URLWithString:url];
    NSData *titledata = [NSData dataWithContentsOfURL:titleURL];
    TFHpple *titleParser = [TFHpple hppleWithHTMLData:titledata];
    NSString *titleXpathQueryString = @"/html/head/title";
    NSArray *title = [titleParser searchWithXPathQuery:titleXpathQueryString];
    TFHppleElement *siteTitle = [title firstObject];
    return siteTitle.text;
}

//Function to return the meta tag description of the selected url

-(NSString*)FetchMetaDescription:(NSString*) url
{
    NSURL *descURL = [NSURL URLWithString:url];
    NSData *descData = [NSData dataWithContentsOfURL:descURL];
    TFHpple *descParser = [TFHpple hppleWithHTMLData:descData];
    NSString *descXpathQueryString = @"//meta[@name='description']/@content";
    NSArray *desc = [descParser searchWithXPathQuery:descXpathQueryString];
    TFHppleElement *siteDesc = [desc firstObject];
    return siteDesc.text;
}

//Function to return the meta tag keywords of the selected url

-(NSString*)FetchMetaKeywords:(NSString*) url
{
    NSURL *keyURL = [NSURL URLWithString:url];
    NSData *keyData = [NSData dataWithContentsOfURL:keyURL];
    TFHpple *keyParser = [TFHpple hppleWithHTMLData:keyData];
    NSString *keyXpathQueryString = @"//meta[@name='keywords']/@content";
    NSArray *key = [keyParser searchWithXPathQuery:keyXpathQueryString];
    TFHppleElement *siteKey = [key firstObject];
    return siteKey.text;
}

//Function to return the number of H1 tags on the selected url

-(int)CountH1Tags:(NSString*) url
{
    NSURL *h1URL = [NSURL URLWithString:url];
    NSData *h1Data = [NSData dataWithContentsOfURL:h1URL];
    TFHpple *h1Parser = [TFHpple hppleWithHTMLData:h1Data];
    NSString *h1XpathQueryString = @"//h1";
    NSArray *h1 = [h1Parser searchWithXPathQuery:h1XpathQueryString];
    return [h1 count];
}

//Function to return the number of H2 tags on the selected url

-(int)CountH2Tags:(NSString*) url
{
    NSURL *h2URL = [NSURL URLWithString:url];
    NSData *h2Data = [NSData dataWithContentsOfURL:h2URL];
    TFHpple *h2Parser = [TFHpple hppleWithHTMLData:h2Data];
    NSString *h2XpathQueryString = @"//h2";
    NSArray *h2 = [h2Parser searchWithXPathQuery:h2XpathQueryString];
    return [h2 count];
}

//Function to return the number of H3 tags on the selected url

-(int)CountH3Tags:(NSString*) url
{
    NSURL *h3URL = [NSURL URLWithString:url];
    NSData *h3Data = [NSData dataWithContentsOfURL:h3URL];
    TFHpple *h3Parser = [TFHpple hppleWithHTMLData:h3Data];
    NSString *h3XpathQueryString = @"//h3";
    NSArray *h3 = [h3Parser searchWithXPathQuery:h3XpathQueryString];
    return [h3 count];
}

//Function to return the number of image tags on the selected url

-(int)CountImages:(NSString*) url
{
    NSURL *imageURL = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    TFHpple *imageParser = [TFHpple hppleWithHTMLData:imageData];
    NSString *imageXpathQueryString = @"//img";
    NSArray *image = [imageParser searchWithXPathQuery:imageXpathQueryString];
    return [image count];
}

//Function to return the number of alt tags of images on the selected url

-(int)CountAlt:(NSString*) url
{
    NSURL *altURL = [NSURL URLWithString:url];
    NSData *altData = [NSData dataWithContentsOfURL:altURL];
    TFHpple *altParser = [TFHpple hppleWithHTMLData:altData];
    NSString *altXpathQueryString = @"//img/@alt";
    NSArray *alt = [altParser searchWithXPathQuery:altXpathQueryString];
    return [alt count];
}

@end
