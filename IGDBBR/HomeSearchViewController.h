//
//  HomeSearchViewController.h
//  IGDBBR
//
//  Created by Rodrigo Heleno on 08/06/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HomeSearchViewController : UIViewController<UITextFieldDelegate>


@property (nonatomic, strong) IBOutlet UITextField *txtSearch;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView * loading;

@property (nonatomic, strong)IBOutlet UIImageView *topoImage;
@property (nonatomic, strong)IBOutlet UIImageView *image1;
@property (nonatomic, strong)IBOutlet UIImageView *image2;
@property (nonatomic, strong)IBOutlet UIImageView *image3;
@property (nonatomic, strong)IBOutlet UIImageView *image4;

@property (nonatomic, strong)IBOutlet UILabel *labelTopo;
@property (nonatomic, strong)IBOutlet UILabel *labelImage1;
@property (nonatomic, strong)IBOutlet UILabel *labelImage2;
@property (nonatomic, strong)IBOutlet UILabel *labelImage3;
@property (nonatomic, strong)IBOutlet UILabel *labelImage4;




@end
