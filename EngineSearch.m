//
//  EngineSearch.m
//  IGDBBR
//
//  Created by Rodrigo Heleno on 12/06/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import "EngineSearch.h"
#import "EngineSearchProtocol.h"
#import "SimpleSearchGame.h"
#import "ComplexSearchGame.h"

@implementation EngineSearch

-(void)executeSearch:(NSString *)searchText executionBlock:(void (^)(NSArray *response))executionBlock{
    if(![self listOfKeyWords:searchText]){
        [[SimpleSearchGame new]executeSearch:searchText executionBlock:^(NSArray *response) {
            executionBlock(response);
        }];
    }else{
        [[ComplexSearchGame new]executeSearch:searchText executionBlock:^(NSArray *response) {
            executionBlock(response);
        }];
    }
    
}

-(BOOL)listOfKeyWords:(NSString*)searchText{
    
    BOOL retorno = NO;
    
    NSArray *listOfWords= @[@"List of", @"Top"];
    NSArray *words = [searchText componentsSeparatedByString:@" "];
    
    for(NSString *key in words){
        for(NSString *word in listOfWords ){
            if([[key lowercaseString] isEqualToString:[word lowercaseString]]){
                retorno = YES;
            }
        }
    }
    
    return retorno;
}

@end
