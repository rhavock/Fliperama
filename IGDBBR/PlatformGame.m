//
//  Platform.m
//  IGDBBR
//
//  Created by resource on 10/03/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlatformGame.h"
#import "Game.h"
#import "DBConnection.h"
#import "Defaults.h"
@implementation PlatformGame
@synthesize offset;
@synthesize platforms;

-(Game*)getPlatformByGameId:(Game*)game{
    int i = 0;
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"platformDictionary"];
    NSMutableDictionary *platdictio =[NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    platforms = [[NSMutableArray alloc]init];
    if([platdictio count] == 0){
        platdictio = [[NSMutableDictionary alloc]init];
        while (i <140 ) {
            NSArray *items =[self getPlatformByGameIdBase:i];
            for(PlatformGame* plat in items){
                if(plat.games != nil)
                    [platdictio addEntriesFromDictionary:@{plat.name:plat.games}];
            }
            i = i + 10;
        }
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:platdictio];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"platformDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    long val = [game.id longValue];
    
    for(NSString* key in platdictio){
        NSArray* arrGames = platdictio[key];
        for(NSNumber* numb in arrGames){
            if([numb longValue] == val){
                PlatformGame *plata = [[PlatformGame alloc]init];
                plata.name = key;
                [platforms addObject:plata];
            }
        }
    }
    
    game.platformGame = platforms;
    return game;
}

-(NSArray*)getPlatformByGameIdBase:(int)offSet{
    NSLog(@"offset %d",offSet);
    NSDictionary *headers = @{@"X-Mashape-Key": @"4rOn6YnZSUmshbDr9NmN7tmEyQMap1djcEZjsnyI4cg6fo4nMv"};
    UNIHTTPJsonResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:[NSString stringWithFormat:@"https://igdbcom-internet-game-database-v1.p.mashape.com/platforms/?fields=*&limit=10&offset=%d",offSet]];
        [request setHeaders:headers];
    }] asJson];
    //:^(UNIHTTPJsonResponse *response, NSError *error) {
    
    UNIJsonNode *body = response.body;
    return [self convertToDomain:body];
    //}];
}

-(NSArray*)convertToDomain:(UNIJsonNode*)response{
    NSMutableArray *platforms = [[NSMutableArray alloc]init];
    for (int i =0; i < [response.array count ]; i++) {
        
        PlatformGame *plat = [[PlatformGame alloc]init];
        plat.name = response.array[i][@"name"];
        plat.id = response.array[i][@"id"];
        plat.slug = response.array[i][@"url"];
        plat.games = response.array[i][@"games"];
        [platforms addObject:plat];
    }
    return platforms;
}

@end
