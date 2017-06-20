//
//  ViewController.h
//  IGDBBR
//
//  Created by resource on 23/02/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"
#import "Game.h"
@interface ViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *summary;
@property (nonatomic, strong) IBOutlet UILabel *storyline;
@property (nonatomic, strong) IBOutlet UILabel *releaseDate;
@property (nonatomic, strong) IBOutlet UILabel *genero;
@property (nonatomic, strong) IBOutlet UILabel *nota;
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) Game* game;
@property (nonatomic, strong) IBOutlet UILabel* counter;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollview;
@property (nonatomic, strong) IBOutlet UILabel* platform;
@property (nonatomic, strong) IBOutlet UIPageControl *page;
@property (nonatomic, strong)IBOutlet UIActivityIndicatorView *loading;
@property (nonatomic, strong)IBOutlet UIActivityIndicatorView *loadingimages;
@property (nonatomic, strong)IBOutlet UIActivityIndicatorView *loadingdetalhes;
@property (nonatomic, strong) IBOutlet UIView *viewRating;
@property (nonatomic, strong) IBOutlet UIView *sly;
@property (nonatomic, strong) IBOutlet UIImageView * imgsly;
@property (nonatomic, strong) IBOutlet UIImageView * imgslyback;
@property (nonatomic, strong)IBOutlet   UIImageView* thumbVideo;
@property (nonatomic) int index;
@property (nonatomic) int totalCount;

@end

