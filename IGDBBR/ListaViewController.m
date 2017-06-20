//
//  ListaViewController.m
//  IGDBBR
//
//  Created by Rodrigo Heleno on 2/28/17.
//  Copyright © 2017 RodrigoHeleno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListaViewController.h"
#import "ListaViewCell.h"
#import "ViewController.h"
#import "PlatformGame.h"
#import "DBConnection.h"

static NSString *const kInterstitialAdUnitID = @"ca-app-pub-6564053570683791/8484204863";

@implementation ListaViewController{
    KYGooeyMenu* menu;
}

@synthesize items;
@synthesize table;
- (void)loadGames {
    [self.loading startAnimating];
//    [[Game alloc]loadGames:^(NSArray<Game *> *games) {
//        items = games;
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
            [table reloadData];
            [self.loading stopAnimating];
//        });
//    }];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    //self.interstitial = [self createAndLoadInterstitial];
      

//    menu = [[KYGooeyMenu alloc]initWithOrigin:CGPointMake(CGRectGetMidX(self.viewMenu.frame)-20, self.viewMenu.frame.origin.y-10) andDiameter:50.0f andDelegate:self themeColor:[UIColor colorWithRed:51/255.0 green:204/255.0 blue:255/255.0 alpha:1.5f ]];
//    menu.radius = 80/4;
//    menu.extraDistance = 20;
//    menu.MenuCount = 3;
//    menu.menuDelegate = self;
//    
//    menu.menuImagesArray = [NSMutableArray arrayWithObjects:
//                            [UIImage imageNamed:@"recent"],
//                            [UIImage imageNamed:@"popular"],
//                            [UIImage imageNamed:@"trophy-icon"], nil];
    
    [self.texto setReturnKeyType:UIReturnKeyDone];
    self.texto.delegate = self;
    
    [self.viewMenu addSubview:menu];
    
    [self loadGames];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden = YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.texto resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_texto resignFirstResponder];
    [self buscarGame];
    return YES;
}
-(void)menuDidSelected:(int)index{
    NSString* sort;
    if(index == 1)
        sort = @"release_dates.date";
    if(index == 2)
        sort = @"popularity";
    if(index == 3)
        sort = @"rating";
    [self.loading startAnimating];
    [[Game alloc]loadGamesBySort:sort callback:^(NSArray<Game *> *games) {
        items = games;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [table reloadData];
            [self.loading stopAnimating];
        });
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"ListaViewCell";
    
    ListaViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListaViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Game *game = [items objectAtIndex:indexPath.row];
    [self.loading startAnimating];  
    [cell setInfo:game];
    [self.loading stopAnimating];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [items count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(IBAction)search{
    
    [self buscarGame];
    
}

-(void)buscarGame{
    [self.loading startAnimating];
    [[Game alloc]loadGamesByName:self.texto.text callback:^(NSArray<Game*>* games) {
        items = games;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [table reloadData];
            [self.loading stopAnimating];
        });
    }];
    [self.view endEditing:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewController *view = [[ViewController alloc]init];
    view.game =[items objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:view animated:YES];
    
}

- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc]
                                     initWithAdUnitID:kInterstitialAdUnitID];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    
    return interstitial;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    if(self.interstitial.isReady){
       
        [self.interstitial presentFromRootViewController:self];
    }
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    
    self.interstitial = [self createAndLoadInterstitial];
}


#pragma mark - Interstitial delegate

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    // Retrying failed interstitial loads is a rudimentary way of handling these errors.
    // For more fine-grained error handling, take a look at the values in GADErrorCode.
    self.interstitial = [self createAndLoadInterstitial];
}


@end
