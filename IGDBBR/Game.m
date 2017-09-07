//
//  Game.m
//  IGDBBR
//
//  Created by resource on 24/02/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"


@implementation Game
@synthesize name;

-(void)loadGamesById:(NSNumber*)id callback:(void(^)(Game* game))callback{
    
<<<<<<< Updated upstream
    NSDictionary *headers = @{@"X-Mashape-Key": @"nSyH5q67jKmshWQuk9mKRqx25V7Pp1xzhtOjsnDOR16ItWX4zM", @"Accept": @"application/json"};
=======
    NSDictionary *headers = @{@"user_key": @"3a178c40eb37da61b9e024908fb72b64", @"Accept": @"application/json"};
>>>>>>> Stashed changes
    [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:[NSString stringWithFormat:@"https://api-2445582011268.apicast.io/games/%@?fields=*&limit=50&offset=0&order=release_dates.date%3Adesc",id]];
        [request setHeaders:headers];
    }]asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        UNIJsonNode *body = response.body;
        
        callback([self convertToDomain:body][0]);
    }];
    
}
-(void)loadGamesByName:(NSString*)search callback:(void(^)(NSArray<Game*>* games))callback{
    
<<<<<<< Updated upstream
    NSDictionary *headers = @{@"X-Mashape-Key": @"nSyH5q67jKmshWQuk9mKRqx25V7Pp1xzhtOjsnDOR16ItWX4zM", @"Accept": @"application/json"};
=======
    NSDictionary *headers = @{@"user-key": @"3a178c40eb37da61b9e024908fb72b64", @"Accept": @"application/json"};
>>>>>>> Stashed changes
    [[UNIRest get:^(UNISimpleRequest *request) {
        NSString *url = [NSString stringWithFormat:@"https://api-2445582011268.apicast.io/games/?fields=*&limit=50&offset=0&search=%@",search];
        [request setUrl:url];
        [request setHeaders:headers];
    }]asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        UNIJsonNode *body = response.body;
        
        callback([self convertToDomain:body]);
    }];
    
}
-(void)loadGamesBySort:(NSString*)sort callback:(void(^)(NSArray<Game*>* games))callback{
    
<<<<<<< Updated upstream
    NSDictionary *headers = @{@"X-Mashape-Key": @"nSyH5q67jKmshWQuk9mKRqx25V7Pp1xzhtOjsnDOR16ItWX4zM", @"Accept": @"application/json"};
=======
     NSDictionary *headers = @{@"user_key": @"3a178c40eb37da61b9e024908fb72b64", @"Accept": @"application/json"};
>>>>>>> Stashed changes
    [[UNIRest get:^(UNISimpleRequest *request) {
        NSString *url = [NSString stringWithFormat:@"https://api-2445582011268.apicast.io/games/?fields=*&limit=50&offset=0&order=%@:desc",sort];
        NSLog(@"%@", url);
        [request setUrl:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [request setHeaders:headers];
    }]asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        UNIJsonNode *body = response.body;
        NSMutableArray *retorno = [self convertToDomain:body];
        int offset = 0;
//        while([retorno count] < 50){
//            offset = offset + 50;
//            retorno = [self loadGamesBySort:sort games:retorno offset:offset];
//            
//        }
        callback(retorno);
        
    }];
    
}
-(NSMutableArray*)loadGamesBySort:(NSString*)sort games:(NSMutableArray*)games offset:(int)offset{
<<<<<<< Updated upstream
    NSDictionary *headers = @{@"X-Mashape-Key": @"nSyH5q67jKmshWQuk9mKRqx25V7Pp1xzhtOjsnDOR16ItWX4zM", @"Accept": @"application/json"};
=======
  NSDictionary *headers = @{@"user_key": @"3a178c40eb37da61b9e024908fb72b64", @"Accept": @"application/json"};
>>>>>>> Stashed changes
    UNIHTTPJsonResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
        NSString *url = [NSString stringWithFormat:@"https://api-2445582011268.apicast.io/games/?fields=*&limit=50&offset=%d&order=%@:desc",offset,sort];
        NSLog(@"%@", url);
        [request setUrl:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [request setHeaders:headers];
    }]asJson ];
    
    UNIJsonNode *body = response.body;
    [games addObjectsFromArray: [self convertToDomain:body]];
    return games;
}
-(void)loadGames:(void(^)(NSArray<Game*>* games))callback{
    [self loadGamesBySort:@"popularity" callback:^(NSArray<Game *> *games) {
        callback(games);
    }];
}

-(void)loadGamesByGenreSortLimit:(NSString *)filter limit:(NSString *)limit sort:(NSString *)sort callback:(void (^)(NSArray<Game *> *))callback{
    NSDictionary *headers = @{@"X-Mashape-Key": @"nSyH5q67jKmshWQuk9mKRqx25V7Pp1xzhtOjsnDOR16ItWX4zM", @"Accept": @"application/json"};
    [[UNIRest get:^(UNISimpleRequest *request) {
        NSString *url = [NSString stringWithFormat:@"https://api-2445582011268.apicast.io/games/?fields=*&limit=%@&order=%@:desc&filter[genres][eq]=%@",limit,sort,filter];
        NSLog(@"%@", url);
        [request setUrl:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [request setHeaders:headers];
    }]asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        UNIJsonNode *body = response.body;
        
        callback([self convertToDomain:body]);
        
    }];
    
}

-(NSArray*)convertToDomain:(UNIJsonNode*)response{
    NSArray *badWords = @[@"hentai",@"sex",@"sexy",@"erotic",@"eroge"];
    NSMutableArray *games = [[NSMutableArray alloc]init];
    for(int i=0; i< [response.array count];i++)
    {
        Game *game = [[Game alloc]init];
        game.summary= response.array[i][@"summary"];
        game.pegi = response.array[i][@"pegi"][@"rating"];
        game.name = response.array[i][@"name"];
        game.storyline= response.array[i][@"storyline"];
        game.genres= response.array[i][@"genres"];
        //        if(game.pegi == nil)
        //            continue;
        //        if(game.summary == nil)
        //            continue;
        //        if(game.name == nil)
        //            continue;
        //        if(game.genres == nil)
        //            continue;
        BOOL loopLeft = NO;
        for(NSString* word in badWords){
            if([game.summary containsString:word])
                loopLeft = YES;
            if([game.name containsString:word])
                loopLeft = YES;
            if([game.storyline containsString:word])
                loopLeft = YES;
        }
        if(loopLeft)
            continue;
        
        game.id = response.array[i][@"id"];;
        game.slug= response.array[i][@"slug"];;
        game.url= response.array[i][@"url"];;
        game.created_at= response.array[i][@"created_at"];;
        game.updated_at= response.array[i][@"updated_at"];;
        game.rating = response.array[i][@"rating"];
        game.aggregated_rating = response.array[i][@"aggregated_rating"];
        game.total_rating_count = response.array[i][@"total_rating_count"];
        game.total_rating = response.array[i][@"total_rating"];
        game.rating_count = response.array[i][@"rating_count"];
        
        
        game.collection= response.array[i][@"collection"];;
        game.hypes= response.array[i][@"hypes"];
        game.popularity= response.array[i][@"popularity"];
        game.category= response.array[i][@"category"];;
        game.first_release_date= response.array[i][@"first_release_date"];
        NSMutableArray<ReleaseDates*> *releaseDates = [[NSMutableArray<ReleaseDates*> alloc]init];
        for (int y = 0; y < [response.array[i][@"release_dates"] count]; y++) {
            ReleaseDates* releaseD = [[ReleaseDates alloc]init];
            releaseD.category = response.array[i][@"release_dates"][y][@"category"];
            releaseD.human = response.array[i][@"release_dates"][y][@"human"];
            releaseD.releasemonth = response.array[i][@"release_dates"][y][@"m"];
            releaseD.releaseyear = response.array[i][@"release_dates"][y][@"y"];
            [releaseDates addObject:releaseD];
        }
        
        game.releasedates= releaseDates;
        NSMutableArray<Screenshots*> *imagens = [[NSMutableArray<Screenshots*> alloc]init];
        for(int j=0;j < [response.array[i][@"screenshots"] count]; j++){
            Screenshots *screenshots = [[Screenshots alloc]init];
            screenshots.url = response.array[i][@"screenshots"][j][@"url"];
            screenshots.width = response.array[i][@"screenshots"][j][@"width"];
            screenshots.height = response.array[i][@"screenshots"][j][@"height"];
            screenshots.cloudinary_id = response.array[i][@"screenshots"][j][@"cloudinary_id"];
            [imagens addObject:screenshots];
        }
        game.screenshots = imagens;
        NSMutableArray *vidoes = [NSMutableArray new];
        for (int l = 0; l < [response.array[i][@"videos"] count]; l++) {
            Videos *video = [Videos new];
            video.name = response.array[i][@"videos"][l][@"name"];
            video.video_id = response.array[i][@"videos"][l][@"video_id"];
            [vidoes addObject:video];
        }
        game.videos = vidoes;
        Cover *cover = [[Cover alloc]init];
        cover.url = response.array[i][@"cover"][@"url"];
        cover.width = response.array[i][@"cover"][@"width"];
        cover.height = response.array[i][@"cover"][@"height"];
        cover.cloudinary_id = response.array[i][@"cover"][@"cloudinary_id"];
        game.cover = cover;
        //    _esrb= response.array[0][@"name"];;
        
<<<<<<< Updated upstream
        //game.platformGame = [self setPlatform:game];
//        game.genreString = [self setGenre:game];
        game.imageBack = [self setImage:game];
=======
//        if([game.screenshots count] != 0){
//            
//            
//            NSString* stringima = [NSString stringWithFormat:@"http:%@", game.screenshots[0].url];
//            NSString* resultado = [stringima stringByReplacingOccurrencesOfString:@"t_thumb"
//                                                                       withString:@"t_screenshot_big"];
//            resultado = [resultado stringByReplacingOccurrencesOfString:@".png"
//                                                             withString:@".jpg"];
//            
//            NSURL *imgURL = [NSURL URLWithString:resultado];
//            
//            UIImage *image = [UIImage imageWithData:UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:imgURL]],0.9)];
//            if(image != nil){
//                game.imageBack = image;
//            }
//        }else{
            game.imageBack = [UIImage imageNamed:@"naotem"];
//        }
>>>>>>> Stashed changes
        [games addObject:game];
    }
    return games;
}

-(UIImage*)setImage:(Game*)game{
    if([game.screenshots count] != 0){
        
        
        NSString* stringima = [NSString stringWithFormat:@"http:%@", game.screenshots[0].url];
        NSString* resultado = [stringima stringByReplacingOccurrencesOfString:@"t_thumb"
                                                                   withString:@"t_screenshot_big"];
        resultado = [resultado stringByReplacingOccurrencesOfString:@".png"
                                                         withString:@".jpg"];
        
        NSURL *imgURL = [NSURL URLWithString:resultado];
        
        UIImage *image = [UIImage imageWithData:UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:imgURL]],0.9)];
        if(image != nil){
            return image;
        }
    }
    return [UIImage imageNamed:@"naotem"];
    
    
}

-(NSString*)setGenre:(Game*)game{
    NSString* genero = @"";
    for (int i = 0; i < game.genres.count; i++) {
        if(i == (game.genres.count - 1)){
            genero =  [genero stringByAppendingString:[[Genres alloc]getGenreById:game.genres[i]]];
        }else{
            genero = [genero stringByAppendingString:[NSString stringWithFormat:@"%@/",[[Genres alloc]getGenreById:game.genres[i]]]];
        }
        
    }
    return genero;
    
}
-(PlatformGame*)setPlatform:(Game*)game{
    PlatformGame *plat = [PlatformGame new];
    plat.name =  [[PlatformGame alloc] getPlatformByGameIdBase:game.id];
    
    return plat;
}

- (void)imageUrl:(NSString *)stringimagem tamanhoImagem:(TamanhoImagem)tamanhoImagem retornoImagem:(void(^)(UIImage* image))retornoImagem {
    NSString* stringima = [NSString stringWithFormat:@"http:%@", stringimagem];
    NSString* resultado = [stringima stringByReplacingOccurrencesOfString:@"t_thumb"
                                                               withString:[self enumToText:tamanhoImagem]];
    NSURL *imgURL = [NSURL URLWithString:resultado];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            UIImage *img = [[UIImage alloc] initWithData:data];
            retornoImagem(img);
            
        }else{
            NSLog(@"%@",connectionError);
        }
    }];
}
-(NSString*)enumToText:(TamanhoImagem)tamanhoImagem{
    switch (tamanhoImagem) {
        case cover_big:
            return @"t_cover_big";
        case cover_small:
            return @"t_cover_small";
        case screenshot_big:
            return @"t_screenshot_big";
        case screenshot_med:
            return @"t_screenshot_med";
        case screenshot_huge:
            return @"t_screenshot_huge";
        case logo_med:
            return @"t_logo_med";
        case micro:
            return @"t_micro";
        case  thumb:
            return @"t_thumb";
        default:
            break;
    }
}
@end
