//
//  MyDeklinationVC.m
//  schluessel
//
//  Created by Mario Russo on 12/30/13.
//  Copyright (c) 2013 theNumberTwo. All rights reserved.
//

#import "MyDeklinationVC.h"
#import "JsonDataLoader.h"

@interface MyDeklinationVC ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *kasusSegControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *sampleUsageLabel;
@end

@implementation MyDeklinationVC

- (void) setSelectedButton:(UIButton *)selectedButton {
    [_selectedButton setSelected:false];
    [selectedButton setSelected:true];
    _selectedButton = selectedButton;
}

- (IBAction)caseSelected:(UIButton *)sender {
    if(sender) {
        [self setSelectedButton:sender];
        CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
        NSDictionary *section = [self getDeklinationSection:hitIndex.section];
            
        if(section) {
            NSArray *deklinations = [section objectForKey:@"genus-deklinations"];
                
            if(deklinations) {
                int index = ([sender tag] - 10); // @see tags in storyboard
                self.sampleUsageLabel.text = [deklinations objectAtIndex:index][@"example"];
            }
        }
    }
}

- (IBAction)kasusChanged:(UISegmentedControl *)sender {
    #warning TODO swap this with a less destructive process - currently relaoding the json file each segment change
    [self.tableView reloadData];
//    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows]
//                     withRowAnimation:UITableViewRowAnimationNone];
    [self setSelectedButton:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchDeklinationData];
}

- (void) fetchDeklinationData
{
    self.data = nil;
    self.data = [JsonDataLoader loadJsonFile:@"adj-dek"];
}

- (NSDictionary *) getCurrentlySelectedKasus {
    NSInteger index = [self.kasusSegControl selectedSegmentIndex];
    
    if(index < [self.data count])
        return self.data[index];
    
    return nil;
}

- (NSDictionary *) getDeklinationSection: (NSUInteger)atIndex {
    NSDictionary *kasus = [self getCurrentlySelectedKasus];
    
    if(kasus) {
        NSArray *deklinationTypes = kasus[@"deklination-types"];
        return [deklinationTypes objectAtIndex:atIndex];
    }
    
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSString *) tableView:(UITableView *)tv titleForHeaderInSection:(NSInteger)s
{
    NSDictionary *section = [self getDeklinationSection:s];
    if(section) {
        return section[@"title"];
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // only want to select buttons in row, not entire row
    return false;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"proto-adj-dek-cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *maskulinText = @"";
    NSString *neutralText = @"";
    NSString *femininText = @"";
    NSString *pluralText = @"";
    
    NSDictionary *section = [self getDeklinationSection:indexPath.section];
    if(section) {
        NSArray *deklinations = [section objectForKey:@"genus-deklinations"];
        maskulinText = [deklinations objectAtIndex:0][@"ending"];
        neutralText = [deklinations objectAtIndex:1][@"ending"];
        femininText = [deklinations objectAtIndex:2][@"ending"];
        pluralText = [deklinations objectAtIndex:3][@"ending"];
    }
    
    UIButton *maskulinBtn = (UIButton *)[cell.contentView viewWithTag:10];
    UIButton *neutralBtn = (UIButton *)[cell.contentView viewWithTag:11];
    UIButton *femininBtn = (UIButton *)[cell.contentView viewWithTag:12];
    UIButton *pluralBtn = (UIButton *)[cell.contentView viewWithTag:13];
    
    [maskulinBtn setTitle:[NSString stringWithFormat:@"-%@", maskulinText] forState:UIControlStateNormal];
    [neutralBtn setTitle:[NSString stringWithFormat:@"-%@", neutralText] forState:UIControlStateNormal];
    [femininBtn setTitle:[NSString stringWithFormat:@"-%@", femininText] forState:UIControlStateNormal];
    [pluralBtn setTitle:[NSString stringWithFormat:@"-%@", pluralText] forState:UIControlStateNormal];
    
    return cell;
}

@end
