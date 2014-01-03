//
//  JsonDataLoader.h
//  schluessel
//
//  Created by Mario Russo on 1/3/14.
//  Copyright (c) 2014 theNumberTwo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonDataLoader : NSObject

+ (NSArray *) loadJsonFile: (NSString *)fromPath;

@end
