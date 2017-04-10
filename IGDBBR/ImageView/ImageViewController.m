//
//  ImageViewController.m
//  IGDBBR
//
//  Created by Mauker Olimpio on 4/7/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController{
    NSMutableArray *_datasource;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    _slideshow.datasource = self;
    _slideshow.delegate = self;
    [_slideshow setDelay:1];
    [_slideshow setTransitionDuration:.5];
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFit];
    [_slideshow addGesture:KASlideShowGestureTap];
    [_slideshow setTransitionType:KASlideShowTransitionSlideHorizontal];
    _slideshow.gestureRecognizers = nil;
    [_slideshow addGesture:KASlideShowGestureSwipe];
    
    [self loadCarousel];
    
    
}
- (void)averageColor:(UIImage*)image{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        self.slideshow.backgroundColor = [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                                                          green:((CGFloat)rgba[1])*multiplier
                                                           blue:((CGFloat)rgba[2])*multiplier
                                                          alpha:alpha];
    }
    else {
        self.slideshow.backgroundColor = [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                                                          green:((CGFloat)rgba[1])/255.0
                                                           blue:((CGFloat)rgba[2])/255.0
                                                          alpha:((CGFloat)rgba[3])/255.0];
    }
}

-(void)loadCarousel{
    _speedSlider.alpha = .5;
    [_speedSlider setUserInteractionEnabled:NO];
    
    NSMutableArray<UIImage*> *source = [[NSMutableArray<UIImage*> alloc]init];
    _datasource = source;
    if([_game.screenshots count] == 0){
        [_datasource addObject:[UIImage imageNamed:@"naotem"]];
        [_slideshow reloadData];
        return;
    }
    
    
    
    
    [_game imageUrl:_game.cover.url tamanhoImagem:cover_big retornoImagem:^(UIImage *image) {
        [_datasource addObject:image];
        [_slideshow reloadData];
    }];
    
    
}


- (NSObject *)slideShow:(KASlideShow *)slideShow objectAtIndex:(NSUInteger)index
{
    
    if(_datasource.count <= 1){
        for(Screenshots *screen in _game.screenshots){
            [_game imageUrl:screen.url tamanhoImagem:screenshot_huge retornoImagem:^(UIImage *image) {
                
                [_datasource addObject:image];
                
            }];	
        }
    }
    _page.numberOfPages =_datasource.count;
    _page.currentPage = index;
    [self averageColor:_datasource[index]];
    return _datasource[index];
}

- (NSUInteger)slideShowImagesNumber:(KASlideShow *)slideShow
{
    return _datasource.count;
}


@end
