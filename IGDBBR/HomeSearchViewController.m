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
#import "ViewController.h"
#import "ListaViewController.h"
@implementation HomeSearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(IBAction)search:(id)sender{
    EngineSearch *search = [EngineSearch new];
    
    [search executeSearch:_txtSearch.text executionBlock:^(NSArray *response) {
        if(response.count == 1){
            dispatch_async(dispatch_get_main_queue(), ^{
                ViewController *view = [[ViewController alloc]init];
                
                    view.game = (Game*)response[0];
                    
                    [self.navigationController pushViewController:view animated:YES];
                
            });
        }else if(response.count == 0){
            //TODO Aviso Usuario
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                ListaViewController *view = [ListaViewController new];
                view.items = response;
                [self.navigationController pushViewController:view animated:YES];
            });
        }
    }];
    
    
    
}

@end
