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

@end
