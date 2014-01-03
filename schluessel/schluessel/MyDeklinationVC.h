//
//  MyDeklinationVC.h
//  schluessel
//
//  Created by Mario Russo on 12/30/13.
//  Copyright (c) 2013 theNumberTwo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDeklinationVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *data;
@property (weak, nonatomic) UIButton *selectedButton;

@end
