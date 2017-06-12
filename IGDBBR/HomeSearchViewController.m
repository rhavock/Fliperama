//
//  HomeSearchViewController.m
//  IGDBBR
//
//  Created by Rodrigo Heleno on 08/06/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import "HomeSearchViewController.h"
#import "EngineSearch.h"
#import "Game.h"

@implementation HomeSearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(IBAction)search:(id)sender{
    EngineSearch *search = [EngineSearch new];
    
    NSArray<Game*>* retorno = [search executeSearch:_txtSearch.text];
    
}

@end
