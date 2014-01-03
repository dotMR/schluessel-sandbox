//
//  VerbFormenViewController.m
//  schluessel
//
//  Created by Mario Russo on 1/3/14.
//  Copyright (c) 2014 theNumberTwo. All rights reserved.
//

#import "VerbFormenViewController.h"
#import "JsonDataLoader.h"

@interface VerbFormenViewController ()

@end

@implementation VerbFormenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchVerbs];
}

- (void) fetchVerbs
{
    self.verbs = nil;
    self.verbs = [JsonDataLoader loadJsonFile:@"verben-formen"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.verbs count];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"verb-form-cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *verb = self.verbs[indexPath.row];
    
    UILabel *infinitivLabel = (UILabel *)[cell.contentView viewWithTag:10];
    UILabel *präsensLabel = (UILabel *)[cell.contentView viewWithTag:11];
    UILabel *präteritumLabel = (UILabel *)[cell.contentView viewWithTag:12];
    UILabel *partizipLabel = (UILabel *)[cell.contentView viewWithTag:13];
    UILabel *hilfsverbenLabel = (UILabel *)[cell.contentView viewWithTag:14];
    
    infinitivLabel.text = [verb valueForKey:@"infinitiv"];
    präsensLabel.text = [verb valueForKey:@"präsens"];
    präteritumLabel.text = [verb valueForKey:@"präteritum"];
    partizipLabel.text = [verb valueForKey:@"partizip-perfekt"];
    hilfsverbenLabel.text = [verb valueForKey:@"hilfsverben"];
    
    return cell;
}

@end
