//
//  ComplexSearchGame.m
//  IGDBBR
//
//  Created by resource on 14/06/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import "ComplexSearchGame.h"
#import "Game.h"
#import "Genres.h"

@implementation ComplexSearchGame

-(void)executeSearch:(NSString *)searchText executionBlock:(void (^)(NSArray *))executionBlock{
    if([[searchText lowercaseString] containsString:@"top"]){
        NSArray* sort = [searchText componentsSeparatedByString:@" "];
        if(sort.count == 2){
            if([[sort[1] lowercaseString] isEqualToString:@"games"] || [[sort[1]lowercaseString] isEqualToString:@"game"] ){
                [[Game new]loadGamesBySort:@"rating" callback:^(NSArray<Game *> *games) {
                    executionBlock(games);
                }];
            }else{
                executionBlock([NSArray new]);
            }
        }else if(sort.count == 3){
            NSString *limit = [NSString new];
            
            NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            if ([sort[1] rangeOfCharacterFromSet:notDigits].location == NSNotFound)
            {
                limit = sort[1];
            }
            
            
            [[Genres new]getGenreByName:[sort[2] capitalizedString]  callback:^(NSString *response) {
                NSString *filter = [NSString new];
                filter = response;
                [[Game new]loadGamesByGenreSortLimit:filter limit:limit sort:@"rating" callback:^(NSArray<Game*>* games){
                    executionBlock(games);
                    return;
                }];
            }];
        }else{
            executionBlock([NSArray new]);
        }
    }
}

@end
