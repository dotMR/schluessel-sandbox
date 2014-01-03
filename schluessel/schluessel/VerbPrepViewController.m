//
//  VerbPrepViewController.m
//  schluessel
//
//  Created by Mario Russo on 12/27/13.
//  Copyright (c) 2013 theNumberTwo. All rights reserved.
//

#import "VerbPrepViewController.h"

@interface VerbPrepViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sentenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *prepositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *infinitiveLabel;

@end

@implementation VerbPrepViewController

- (void) setVerb:(NSDictionary *)verb
{
    _verb = verb;
    self.title = @"Usage";
}

- (void)viewDidLoad
{
    self.infinitiveLabel.text = [self.verb valueForKey:@"Infinitive"];
    self.prepositionLabel.text = [self.verb valueForKey:@"Prep"];
    self.sentenceLabel.text = [self.verb valueForKey:@"Sentence"];
}

@end
