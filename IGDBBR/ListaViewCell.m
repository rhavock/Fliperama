//
//  ListaViewCell.m
//  IGDBBR
//
//  Created by Rodrigo Heleno on 3/3/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListaViewCell.h"
#import "PlatformGame.h"

@implementation ListaViewCell
@synthesize imagem;
@synthesize name;
@synthesize genero;
@synthesize releaseDate;
@synthesize nota;
@synthesize platform;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
    }
    
    return self;
}

- (void)setImageCover {
    //[self.loadingImage startAnimating];
    
    if([_game.id longValue] == 16309 || [_game.id longValue] == 22425){
        imagem.image = [UIImage imageNamed:@"naotem"];
        return;
    }
    if (_game.cover.url != nil) {
        [[Game alloc] imageUrl:_game.cover.url tamanhoImagem:cover_big retornoImagem:^(UIImage *imagen) {
            @try {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(imagen ==nil){
                        imagem.image = [UIImage imageNamed:@"naotem"];
                        return;
                    }
                    
                    imagem.image = imagen;
                    //[self.loadingImage stopAnimating];
                });
            } @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
        }];
    }
    else{
        imagem.image = [UIImage imageNamed:@"naotem"];
        //[self.loadingImage stopAnimating];
    }
}

- (void)setGenero {
    if (_game.genres.count > 0){
        Genres *genre = [[Genres alloc]init];
        NSString* genreId = (NSString*)_game.genres[0];
        [genre getGenreById:genreId callback:^(Genres *genre) {
            @try {
                dispatch_async(dispatch_get_main_queue(), ^{
                    genero.text = genre.name;
                    
                });
            } @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
        }];
    }
}

-(void)setInfo:(Game *)game{
    self.game = game;
    
    name.text = game.name;
    int Nota = [game.rating intValue];
    nota.text =  [NSString stringWithFormat:@"%d", Nota];
    
    if (game.releasedates.count > 0){
        releaseDate.text = [game.releasedates[0].releaseyear stringValue];
    }
    
    imagem.image = nil;
    genero.text = nil;
    
    [self setImageCover];
    [self setPlatforms];
    [self setGenero];
    
}
-(void)setPlatforms{
    
   self.platform.text =_game.platformGame.name;
    
}
@end
