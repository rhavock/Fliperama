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
#import "Utils.h"

@implementation PlatformGame
@synthesize offset;

-(Game*)getPlatformByGameId:(Game*)game{
    
    PlatformGame *plata = [[PlatformGame alloc]init];
    NSString *plataformas = [[NSString alloc]init];
    NSArray *plats = [self getPlatformByGameIdBase:game.id];
    for (int i = 0; i < plats.count; i++) {
        if(i == (plats.count - 1)){
          plataformas =  [plataformas stringByAppendingString:((PlatformGame*)plats[i]).name];
        }else{
            plataformas = [plataformas stringByAppendingString:[NSString stringWithFormat:@"%@/",((PlatformGame*)plats[i]).name]];
        }
    }
    
    plata.name = plataformas;
    
    game.platformGame = plata;
    return game;
}

-(NSArray*)getPlatformByGameIdBase:(NSNumber*)gameID{
    
    NSDictionary *headers = @{@"X-Mashape-Key": @"4rOn6YnZSUmshbDr9NmN7tmEyQMap1djcEZjsnyI4cg6fo4nMv"};
    UNIHTTPJsonResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:[NSString stringWithFormat:@"https://igdbcom-internet-game-database-v1.p.mashape.com/platforms/?fields=*&limit=50&offset=1&filter[games][eq]=%@",gameID]];
        [request setHeaders:headers];
    }] asJson];
    
    UNIJsonNode *body = response.body;
    return [self convertToDomain:body];
}

-(NSArray*)convertToDomain:(UNIJsonNode*)response{
    NSMutableArray *platforms = [[ NSMutableArray alloc]init];
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
