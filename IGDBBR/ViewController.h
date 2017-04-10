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
@interface ViewController : UIViewController<KASlideShowDelegate>
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *summary;
@property (nonatomic, strong) IBOutlet UILabel *storyline;
@property (nonatomic, strong) IBOutlet UILabel *releaseDate;
@property (nonatomic, strong) IBOutlet UILabel *genero;
@property (nonatomic, strong) IBOutlet UIImageView *image;
@property (nonatomic, strong) Game* game;
@property (nonatomic, strong) IBOutlet UILabel* counter;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollview;
@property (nonatomic, strong) IBOutlet UILabel* platform;
@property (nonatomic, strong) IBOutlet UIPageControl *page;
@end

