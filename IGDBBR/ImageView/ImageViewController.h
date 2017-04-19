//
//  ImageViewController.h
//  IGDBBR
//
//  Created by Mauker Olimpio on 4/7/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KASlideShow.h"
#import "Game.h"

@interface ImageViewController : UIViewController<KASlideShowDelegate,KASlideShowDataSource>
@property (strong, nonatomic) IBOutlet KASlideShow * slideshow;
@property (strong, nonatomic) IBOutlet UISlider *speedSlider;
@property (strong, nonatomic) Game* game;
@property (strong, nonatomic) IBOutlet UIPageControl *page;
@property (strong, nonatomic) IBOutlet UIImageView *imageVw;
@end
