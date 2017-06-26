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

-(NSString*)getGenreById:(NSNumber *)generoID{
    NSDictionary *headers = @{@"X-Mashape-Key": @"nSyH5q67jKmshWQuk9mKRqx25V7Pp1xzhtOjsnDOR16ItWX4zM"};
    UNIHTTPJsonResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:[NSString stringWithFormat:@"https://igdbcom-internet-game-database-v1.p.mashape.com/genres/%@?fields=*&limit=40",generoID]];
        [request setHeaders:headers];
    }] asJson];
        UNIJsonNode *body = response.body;
    
    return body.array[0][@"name"];
    
}

-(void)getGenreByName:(NSString*)genreString callback:(void(^)(NSString* response))callback{
    NSDictionary *headers = @{@"X-Mashape-Key": @"nSyH5q67jKmshWQuk9mKRqx25V7Pp1xzhtOjsnDOR16ItWX4zM"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:[NSString stringWithFormat:@"https://igdbcom-internet-game-database-v1.p.mashape.com/genres/?fields=*&filter[name][eq]=%@",genreString]];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        UNIJsonNode *body = response.body;
        _id = body.array[0][@"id"];
        callback(_id);
    }];
}
@end
