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
    
    if(_game.imageBack != nil){
        self.imgBack.image = _game.imageBack;
    }
    imagem.layer.shadowColor = [UIColor blackColor].CGColor;
    imagem.layer.shadowOffset = CGSizeMake(1.0, 1.0);
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
    self.rating.layer.cornerRadius = 15;
    self.rating.textAlignment = NSTextAlignmentCenter;
    self.rating.layer.borderWidth = 2;
    self.rating.layer.borderColor = [UIColor greenColor].CGColor;
    self.rating.layer.shadowColor = [UIColor blackColor].CGColor;
    self.rating.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.rating.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    int Nota = [game.rating intValue];
    _rating.text =  [NSString stringWithFormat:@"%d", Nota];
    
    
    if (game.releasedates.count > 0){
        releaseDate.text = [game.releasedates[0].releaseyear stringValue];
    }
    
    imagem.image = nil;
    genero.text = nil;
    
    [self setImageCover];
    //[self setPlatforms];
    //[self setGenero];
    
}
-(void)setPlatforms{
    
    self.platform.text =_game.platformGame.name;
    
}
@end
