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
    
    [self loadTop5Games];
    
}


-(void)loadTop5Games{
    [self.loading startAnimating];
    [[Game new]loadGamesBySort:@"popularity" callback:^(NSArray<Game *> *games) {
        for (int i =0; i < 6; i++) {
            switch (i) {
                case 0:
                    _topoImage.image = games[0].imageBack;
                    _labelTopo.text = games[0].name;
                    break;
                case 1:
                    _image1.image = games[1].imageBack;
                    _labelImage1.text = games[1].name;
                    break;
                case 2:
                    _image2.image = games[2].imageBack;
                    _labelImage2.text = games[2].name;
                    break;
                case 3:
                    _image3.image = games[3].imageBack;
                    _labelImage3.text = games[3].name;
                    break;
                case 4:
                    _image4.image = games[4].imageBack;
                    _labelImage4.text = games[4].name;
                default:
                    [self.loading stopAnimating];
                    return;
                    break;
            }
            
            
        }
        
    }];
    
    
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
