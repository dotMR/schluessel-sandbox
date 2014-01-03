//
//  VerbTableViewController.m
//  schluessel
//
//  Created by Mario Russo on 12/26/13.
//  Copyright (c) 2013 theNumberTwo. All rights reserved.
//

#import "VerbTableViewController.h"
#import "VerbPrepViewController.h"

@interface VerbTableViewController ()

@end

@implementation VerbTableViewController

- (void) setVerbs:(NSArray *)verbs
{
    _verbs = verbs;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchVerbs];
}

- (void) fetchVerbs
{
    self.verbs = nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"verb-prep" ofType:@"plist"];
    NSDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    self.verbs = [dict objectForKey:@"verbs-preps"];
}

#warning TODO: need to implement jump-to menu?
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return[NSArray arrayWithObjects:@"a", @"e", @"i", @"m", @"p", nil];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.verbs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"verb-prep-cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *verb = self.verbs[indexPath.row];
    
    cell.textLabel.text = [verb valueForKey:@"Infinitive"];
    cell.detailTextLabel.text = [verb valueForKey:@"Prep"];
    
    return cell;
}

-(void) prepareVerbViewController: (VerbPrepViewController *)vvc toDisplay: (NSDictionary *)verbToDisplay {
    vvc.verb = verbToDisplay;
//    vvc.title = [verbToDisplay valueForKey:@"Infinitive"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass: [UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath) {
            if( [segue.identifier isEqualToString:@"Display Verb Usage"]) {
                if( [segue.destinationViewController isKindOfClass:[VerbPrepViewController class]]) {
                    [self prepareVerbViewController:segue.destinationViewController toDisplay:self.verbs[indexPath.row]];
                }
            }
        }
    }
    
}

@end
