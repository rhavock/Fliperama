//
//  SimpleSearchGame.m
//  IGDBBR
//
//  Created by resource on 14/06/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import "SimpleSearchGame.h"
#import "Game.h"
@implementation SimpleSearchGame

-(void)executeSearch:(NSString *)searchText executionBlock:(void(^)(NSArray* response))executionBlock{
    
    [[Game new] loadGamesByName:searchText callback:^(NSArray<Game *> *games) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", searchText];
        
        NSArray<Game*> *array = [games filteredArrayUsingPredicate:predicate];
        
        if(array.count == 0 && games.count > 0)
            executionBlock(games);
        else
            executionBlock(array);
    }];
}

@end
