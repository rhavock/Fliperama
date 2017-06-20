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
    [self.txtSearch setReturnKeyType:UIReturnKeyDone];
    self.txtSearch.delegate = self;
    
}

-(IBAction)search:(id)sender{
    [self.loading startAnimating];
    EngineSearch *search = [EngineSearch new];
    
    [search executeSearch:_txtSearch.text executionBlock:^(NSArray *response) {
        if(response.count == 1){
            dispatch_async(dispatch_get_main_queue(), ^{
                ViewController *view = [[ViewController alloc]init];
                
                view.game = (Game*)response[0];
                
                [self.navigationController pushViewController:view animated:YES];
                [self.loading stopAnimating];
                
            });
        }else if(response.count == 0){
            
            dispatch_async(dispatch_get_main_queue(),^{
                UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"Atention"
                                                                              message:@"No games has been founded"
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action)
                                            {
                                                
                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                                [self.loading stopAnimating];
                                            }];
                
                
                [alert addAction:yesButton];
                
                [self.navigationController presentViewController:alert animated:YES completion:nil];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                ListaViewController *view = [ListaViewController new];
                view.items = response;
                [self.navigationController pushViewController:view animated:YES];
                [self.loading stopAnimating];
            });
        }
    }];
    
    
    
}

@end
