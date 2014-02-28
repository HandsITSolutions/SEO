//
//  AppFunctions.h
//  SEO
//
//  Created by Jamie Hands on 2/11/14.
//  Copyright (c) 2014 Chameleon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppFunctions : NSObject

-(BOOL)CheckSitemap:(NSString*) url;
-(BOOL)CheckRobots:(NSString*) url;
-(NSString*)FetchTitle:(NSString*) url;
-(NSString*)FetchMetaDescription:(NSString*) url;
-(NSString*)FetchMetaKeywords:(NSString*) url;
-(int)CountH1Tags:(NSString*) url;
-(int)CountH2Tags:(NSString*) url;
-(int)CountH3Tags:(NSString*) url;
-(int)CountImages:(NSString*) url;
-(int)CountAlt:(NSString*) url;

@end
