//
//  Defaults.m
//  BOM.iOS
//
//  Created by resource on 23/02/17.
//  Copyright © 2017 resource. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defaults.h"

@implementation Defaults

+(void)addDefaults:(NSObject*)value name:(NSString*)name{
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:value forKey:name];
    [preferences synchronize];
}

+(NSObject*)getDefaults:(NSString*)keyName{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if (([preferences objectForKey:keyName] == nil)){
        return nil;
    }
    
    return [preferences stringForKey:keyName];
}

+(NSString*)getArchiveDefault:(NSString*)keyName{
    NSData *customer = [[NSUserDefaults standardUserDefaults] objectForKey:keyName];
    NSString *filterCustomer = [NSKeyedUnarchiver unarchiveObjectWithData:customer];
    
    return filterCustomer;
}
@end
