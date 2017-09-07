//
//  ViewController.m
//  IGDBBR
//
//  Created by resource on 23/02/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import "ViewController.h"
#import "UNIRest.h"
#import "Game.h"
#import "KASlideShow.h"
#import "PlatformGame.h"
#import "ImageViewController.h"
<<<<<<< Updated upstream
#import <MediaPlayer/MediaPlayer.h>
#import "HCYoutubeParser.h"

@import AVFoundation;
@import AVKit;
=======
#import <SDWebImage/UIImageView+WebCache.h>
>>>>>>> Stashed changes

@import GoogleMobileAds;

static NSString *const kBannerAdUnitID = @"ca-app-pub-6564053570683791/1321622064";
@interface ViewController ()
@property(nonatomic, weak) IBOutlet GADBannerView *bannerView;
@end


@implementation ViewController
{
    NSMutableArray * _datasource;
}
@synthesize game;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loading startAnimating];
    self.navigationController.navigationBar.hidden = NO;

    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [_imgsly setUserInteractionEnabled:YES];
    [_imgsly addGestureRecognizer:singleTap];
    
    self.bannerView.adUnitID = kBannerAdUnitID;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.sly addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.sly addGestureRecognizer:swipeRight];
    
    _name.text = game.name;
    _summary.text = [game.summary stringByRemovingPercentEncoding];
    dispatch_async(dispatch_get_main_queue(), ^{
        _storyline.text = game.storyline;
        [self.loadingdetalhes stopAnimating];
    });
    
<<<<<<< Updated upstream
=======
    if(game.cover.url != nil){
        
        NSString* resultado = [self.game.cover.url stringByReplacingOccurrencesOfString:@"t_thumb"
                                                                             withString:@"t_cover_big"];
        resultado = [resultado stringByReplacingOccurrencesOfString:@".png"
                                                         withString:@".jpg"];
        
        
        [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",resultado]] placeholderImage:[UIImage imageNamed:@"naotem"] options:SDWebImageRefreshCached];
        
        
        [self averageColor];
        [self.loadingdetalhes stopAnimating];
        
    }
    else{
        _image.image = [UIImage imageNamed:@"naotem"];
    }
>>>>>>> Stashed changes
    [self loadCarousel];
    [self loadPlatform];
    [self loadReleaseDate];
    [self loadRating];
    [self loadGenre];
    //self loadVideos];
    [self.loadingdetalhes stopAnimating];
    [self.loading stopAnimating];
}
- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.imgsly.transform = CGAffineTransformMakeTranslation( - self.imgsly.layer.frame.size.width +10, 0);
                         }
                         completion:^(BOOL finished){
                             self.index++;
                             if(self.index >= self.totalCount){
                                 self.index = 0;
                             }
                             if(self.index + 1 >= self.totalCount)
                                 self.imgslyback.image = _datasource[1];
                             else
                                 self.imgslyback.image = _datasource[self.index +1];
                             
                             self.imgsly.image = _datasource[self.index];
                             
                             _page.currentPage = 	self.index;
                             
                             self.imgsly.transform = CGAffineTransformMakeTranslation(0, 0);
                         }];
        NSLog(@"Swipe Left");
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if(self.index > 0){
            
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.imgsly.transform = CGAffineTransformMakeTranslation(self.imgsly.layer.frame.size.width +10, 0);
                             }
                             completion:^(BOOL finished){
                                 self.index--;
                                 if(self.index -1 >= 0)
                                     self.imgslyback.image = _datasource[self.index-1];
                                 self.imgsly.image = _datasource[self.index];
                                 _page.currentPage = 	self.index;
                                 
                                 
                                 self.imgsly.transform = CGAffineTransformMakeTranslation(0, 0);
                             }];
        }
        NSLog(@"Swipe Right");
    }
}
-(void)loadRating{
    self.nota.layer.cornerRadius = 20;
    self.nota.textAlignment = NSTextAlignmentCenter;
    self.nota.layer.borderWidth = 2;
    self.nota.layer.borderColor = [UIColor greenColor].CGColor;
    self.nota.layer.backgroundColor = [UIColor clearColor].CGColor;
    int Nota = [game.rating intValue];
    self.nota.text = [NSString stringWithFormat:@"%d", Nota];
    
    self.notaTotal.layer.cornerRadius = 20;
    self.notaTotal.textAlignment = NSTextAlignmentCenter;
    self.notaTotal.layer.borderWidth = 2;
    self.notaTotal.layer.borderColor = [UIColor greenColor].CGColor;
    self.notaTotal.layer.backgroundColor = [UIColor clearColor].CGColor;
    Nota = [game.total_rating intValue];
    self.notaTotal.text = [NSString stringWithFormat:@"%d", Nota];
    
    self.notaAgregada.layer.cornerRadius = 20;
    self.notaAgregada.textAlignment = NSTextAlignmentCenter;
    self.notaAgregada.layer.borderWidth = 2;
    self.notaAgregada.layer.borderColor = [UIColor greenColor].CGColor;
    self.notaAgregada.layer.backgroundColor = [UIColor clearColor].CGColor;
    Nota = [game.aggregated_rating intValue];
    self.notaAgregada.text = [NSString stringWithFormat:@"%d", Nota];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.scrollview.contentSize = CGSizeMake(0,1500);
    
}
-(void)tapDetected{
    
    ImageViewController *imag = [[ImageViewController alloc]init];
    imag.game = game;
    
    [self.navigationController pushViewController:imag animated:YES];
    
}

-(void)loadPlatform{
    game.platformGame = [game setPlatform:game];
    self.platform.text =game.platformGame.name;
    
}

-(void)loadReleaseDate{
    ReleaseDates *dates = [[ReleaseDates alloc]init];
    if([game.releasedates count] > 0 ){
        dates = game.releasedates[0];
        if(dates.releaseyear != nil){
            _releaseDate.text = [dates.releaseyear stringValue];
        }
    }
}
- (void)averageColor {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), game.imageBack.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3]/255.0);
        CGFloat multiplier = alpha/255.0;
        UIColor *cor = [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                                       green:((CGFloat)rgba[1])*multiplier
                                        blue:((CGFloat)rgba[2])*multiplier
                                       alpha:alpha];
        self.viewRating.backgroundColor = cor;
        
        self.navigationController.navigationBar.backgroundColor = cor;
        self.navigationController.navigationBar.tintColor = cor;
    }
    else {
        UIColor *cor =[UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                                      green:((CGFloat)rgba[1])/255.0
                                       blue:((CGFloat)rgba[2])/255.0
                                      alpha:((CGFloat)rgba[3])/255.0];
        self.viewRating.backgroundColor = cor;
        self.navigationController.navigationBar.backgroundColor = cor;
        self.navigationController.navigationBar.tintColor = cor;
    }
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.viewRating.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.viewRating.backgroundColor = [UIColor clearColor];
    //[self.viewRating addSubview:blurEffectView];

}

-(void)loadGenre{
    NSString* genreId = (NSString*)game.genres[0];
    if(genreId != nil){
        _genero.text = [self.game setGenre:self.game];
    }
}

-(void)loadCarousel{
    
    [self.loadingimages startAnimating];
    
    NSMutableArray<UIImage*> *source = [[NSMutableArray<UIImage*> alloc]init];
    _datasource = source;
    if(game.cover.url != nil){
        [self.loadingdetalhes startAnimating];
        
        NSString *urlImage = game.cover.url ;
        urlImage = [urlImage stringByReplacingOccurrencesOfString:@".png"
                                                       withString:@".jpg"];
        [game imageUrl:urlImage tamanhoImagem:screenshot_big retornoImagem:^(UIImage *image) {
            @try {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_datasource addObject:image];
                    self.totalCount++;
                    [self averageColor];
                    [self.loadingdetalhes stopAnimating];
                    
                });
            } @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
            
        }];
    }
    else{
        _image.image = [UIImage imageNamed:@"naotem"];
    }

<<<<<<< Updated upstream
    if([game.screenshots count] == 0){
        self.imgsly.image = [UIImage imageNamed:@"naotem"];
        return;
    }
=======
-(void)loadCarousel{
    
//    [self.loadingimages startAnimating];
//    
//    NSMutableArray<UIImage*> *source = [[NSMutableArray<UIImage*> alloc]init];
//    _datasource = source;
//    if([game.screenshots count] == 0){
//        self.imgsly.image = [UIImage imageNamed:@"naotem"];
//        return;
//    }
    
    NSMutableArray *urls = [NSMutableArray new];
>>>>>>> Stashed changes
    
    
    for(Screenshots *screen in game.screenshots){
        //[game imageUrl:screen.url tamanhoImagem:screenshot_huge retornoImagem:^(UIImage *image) {
        NSString* resultado = [screen.url stringByReplacingOccurrencesOfString:@"t_thumb"
                                                                             withString:@"t_screenshot_big"];
        [urls addObject:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",resultado]]];
          //  self.imgslyback.image = image;
            self.index=0;
            
           // [_datasource addObject:image];
            //_page.numberOfPages =++self.totalCount;
//            [self.loadingimages stopAnimating];
        //}];
    }
    
    [self.imgsly sd_setAnimationImagesWithURLs:urls];
    self.imgsly.animationDuration = 35;
}

-(void)loadVideos{
    
    for (int i = 0; i < game.videos.count; i++) {
        
        
        
        NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@",@"https://www.youtube.com/watch?v=",game.videos[i].video_id]];
        
        AVPlayer *player = [AVPlayer playerWithURL:url];
        
        //NSDictionary *videos = [HCYoutubeParser h264videosWithYoutubeURL:url];
        
        
        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
        [controller setPlayer:player];
        [self presentViewController:controller animated:YES completion:nil];
        //    controller.player = player;
        //    [player play];
        // To get a thumbnail for an image there is now a async method for that
        [HCYoutubeParser thumbnailForYoutubeURL:url
                                  thumbnailSize:YouTubeThumbnailDefaultHighQuality
                                  completeBlock:^(UIImage *image, NSError *error) {
                                      if (!error) {
                                          [_datasource addObject:image];
                                      }
                                      else {
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                                          [alert show];
                                      }
                                  }];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
