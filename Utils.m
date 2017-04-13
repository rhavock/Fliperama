//
//  Utils.m
//  IGDBBR
//
//  Created by resource on 13/04/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import "Utils.h"
#import "PlatformGame.h"

@implementation Utils
static NSMutableDictionary *plats;

+ (void)initialize
{
    plats = [[NSMutableDictionary alloc]init];
}

+ (NSString *)getWithId:(NSNumber *)id
{
    if([plats count] == 0){
        int i = 0;
        while (i <140 ) {
            NSArray *items =[[PlatformGame alloc] getPlatformByGameIdBase:i];
            for(PlatformGame* plat in items){
                if(plat.games != nil)
                    for(NSNumber* gameId in plat.games){
                        NSString* plataforma =plats[gameId];
                        if(!plataforma)
                            [plats addEntriesFromDictionary:@{gameId:plat.name}];
                        else{
                            plataforma = [NSString stringWithFormat:@"%@/%@", plataforma, plat.name];
                            plats[gameId] = plataforma;
                        }
                    }
            }
            i = i + 10;
        }
    }
    return plats[id];
    
}
@end
