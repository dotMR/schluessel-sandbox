//
//  VerbFormenViewController.h
//  schluessel
//
//  Created by Mario Russo on 1/3/14.
//  Copyright (c) 2014 theNumberTwo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerbFormenViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *verbs; // of verb object NSDictionaries

@end
