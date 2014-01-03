//
//  JsonDataLoader.m
//  schluessel
//
//  Created by Mario Russo on 1/3/14.
//  Copyright (c) 2014 theNumberTwo. All rights reserved.
//

#import "JsonDataLoader.h"

@implementation JsonDataLoader

#warning TODO: add error checking to this method
+ (NSArray *) loadJsonFile: (NSString *)fromPath {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:fromPath ofType:@"json"];
    
    NSError *error1;
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error1];
    
    NSError *error2;
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error2];
    
    return jsonData;
}

@end
