//
//  ViewController.m
//  IGDBBR
//
//  Created by resource on 23/02/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import "ViewController.h"
#import <UNIRest.h>
#import "Game.h"
#import "KASlideShow.h"
#import "PlatformGame.h"
#import "ImageViewController.h"

@import GoogleMobileAds;

static NSString *const kBannerAdUnitID = @"ca-app-pub-6564053570683791/1321622064";
@interface ViewController ()
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;
@property (strong, nonatomic) IBOutlet UISlider *speedSlider;
@property(nonatomic, weak) IBOutlet GADBannerView *bannerView;
@end


@implementation ViewController
{
    NSMutableArray * _datasource;
}
@synthesize game;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [_image setUserInteractionEnabled:YES];
    [_image addGestureRecognizer:singleTap];
    
    self.bannerView.adUnitID = kBannerAdUnitID;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    _slideshow.datasource = self;
    _slideshow.delegate = self;
    [_slideshow setDelay:1]; // Delay between transitions
    [_slideshow setTransitionDuration:.5]; // Transition duration
    [_slideshow setTransitionType:KASlideShowTransitionFade]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    [_slideshow addGesture:KASlideShowGestureTap]; // Gesture to go previous/next directly on the image
    [_slideshow setTransitionType:KASlideShowTransitionSlideHorizontal];
    _slideshow.gestureRecognizers = nil;
    [_slideshow addGesture:KASlideShowGestureSwipe];
    _name.text = game.name;
    _summary.text = [game.summary stringByRemovingPercentEncoding];
    _storyline.text = game.storyline;
    
    if(game.cover.url != nil){
        
        [game imageUrl:game.cover.url tamanhoImagem:cover_big retornoImagem:^(UIImage *image) {
            @try {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _image.image = image;
                    [self averageColor];
                    
                });
            } @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
            
        }];
    }
    else{
        _image.image = [UIImage imageNamed:@"naotem"];
    }
    [self loadCarousel];
    [self loadGenre];
    [self loadPlatform];
    [self loadReleaseDate];
    
    
 }

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.scrollview.contentSize = CGSizeMake(0,1600);
    
}
-(void)tapDetected{
    
    ImageViewController *imag = [[ImageViewController alloc]init];
    imag.game = game;
    
    [self.navigationController pushViewController:imag animated:YES];
    
}

-(void)loadPlatform{
    PlatformGame* plats = [[PlatformGame alloc]init];
    game = [plats getPlatformByGameId:game];
    
    
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
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), _image.image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        self.scrollview.backgroundColor = [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                                                          green:((CGFloat)rgba[1])*multiplier
                                                           blue:((CGFloat)rgba[2])*multiplier
                                                          alpha:alpha];
    }
    else {
        self.scrollview.backgroundColor = [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                                                          green:((CGFloat)rgba[1])/255.0
                                                           blue:((CGFloat)rgba[2])/255.0
                                                          alpha:((CGFloat)rgba[3])/255.0];
    }
}

-(void)loadGenre{
    Genres *genre = [[Genres alloc]init];
    NSString* genreId = (NSString*)game.genres[0];
    if(genreId != nil){
        [genre getGenreById:genreId callback:^(Genres *genre) {
            
            @try {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _genero.text = genre.name;
                });
            } @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
            
        }];
    }
}

-(void)loadCarousel{
    _speedSlider.alpha = .5;
    [_speedSlider setUserInteractionEnabled:NO];
    
    NSMutableArray<UIImage*> *source = [[NSMutableArray<UIImage*> alloc]init];
    _datasource = source;
    if([game.screenshots count] == 0){
        [_datasource addObject:[UIImage imageNamed:@"naotem"]];
        [_slideshow reloadData];
        return;
    }
    
    
    for(Screenshots *screen in game.screenshots){
        [game imageUrl:screen.url tamanhoImagem:screenshot_huge retornoImagem:^(UIImage *image) {
            
            [_datasource addObject:image];
            [_slideshow reloadData];
        }];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KASlideShow datasource

- (NSObject *)slideShow:(KASlideShow *)slideShow objectAtIndex:(NSUInteger)index
{
    
    _page.numberOfPages =_datasource.count;
    _page.currentPage = 	index;
    return _datasource[index];
}

- (NSUInteger)slideShowImagesNumber:(KASlideShow *)slideShow
{
    return _datasource.count;
}

#pragma mark - KASlideShow delegate

- (void) slideShowWillShowNext:(KASlideShow *)slideShow
{
    self.counter.text = [NSString stringWithFormat:@"%lu / %lu",(unsigned long)slideShow.currentIndex+1,(unsigned long)_datasource.count];
    NSLog(@"slideShowWillShowNext, index : %@",@(slideShow.currentIndex));
}

- (void) slideShowWillShowPrevious:(KASlideShow *)slideShow
{
    self.counter.text = [NSString stringWithFormat:@"%lu / %lu",(unsigned long)slideShow.currentIndex + 1,(unsigned long)_datasource.count];
    NSLog(@"slideShowWillShowPrevious, index : %@",@(slideShow.currentIndex));
}

- (void) slideShowDidShowNext:(KASlideShow *)slideShow
{
    self.counter.text = [NSString stringWithFormat:@"%lu / %lu",(unsigned long)slideShow.currentIndex+1,(unsigned long)_datasource.count];
    NSLog(@"slideShowDidShowNext, index : %@",@(slideShow.currentIndex));
}

-(void) slideShowDidShowPrevious:(KASlideShow *)slideShow
{
    self.counter.text = [NSString stringWithFormat:@"%lu / %lu",(unsigned long)slideShow.currentIndex+1,(unsigned long)_datasource.count];
    NSLog(@"slideShowDidShowPrevious, index : %@",@(slideShow.currentIndex));
}





@end
