//
//  Genres.m
//  IGDBBR
//
//  Created by resource on 24/02/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Genres.h"
#import <UNIRest.h>

@implementation Genres

-(void)getGenreById:(NSString *)id callback:(void (^)(Genres *genre))callback{
    NSDictionary *headers = @{@"X-Mashape-Key": @"4rOn6YnZSUmshbDr9NmN7tmEyQMap1djcEZjsnyI4cg6fo4nMv"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:[NSString stringWithFormat:@"https://igdbcom-internet-game-database-v1.p.mashape.com/genres/%@?fields=*&limit=40",id]];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        UNIJsonNode *body = response.body;
        _name = body.array[0][@"name"];
        callback(self);
    }];
}

@end
