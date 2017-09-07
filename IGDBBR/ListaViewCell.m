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
#import <SDWebImage/UIImageView+WebCache.h>

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
    
    //if(_game.imageBack != nil){
        //self.imgBack.image = [
    //}
    
    NSString* resultado = [self.game.cover.url stringByReplacingOccurrencesOfString:@"t_thumb"
                                                                                                  withString:@"t_screenshot_big"];
                                       resultado = [resultado stringByReplacingOccurrencesOfString:@".png"
                                                                                        withString:@".jpg"];
    
    
    [self.imgBack sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",resultado]] placeholderImage:[UIImage imageNamed:@"naotem"] options:SDWebImageRefreshCached];
    
    imagem.layer.shadowColor = [UIColor blackColor].CGColor;
    imagem.layer.shadowOffset = CGSizeMake(1.0, 1.0);
}

- (void)setGenero {
    genero.text = _game.genreString;
    
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
    [self setPlatforms];
    [self setGenero];
    
}
-(void)setPlatforms{
    
    self.platform.text =_game.platformGame.name;
    
}
@end
