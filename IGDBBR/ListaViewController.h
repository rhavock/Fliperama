#import <UIKit/UIKit.h>
#import "Game.h"
@import GoogleMobileAds;
#import "KYGooeyMenu.h"

@interface ListaViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,menuDidSelectedDelegate,GADInterstitialDelegate>
@property (nonatomic, strong) NSArray<Game*>* items;
@property (nonatomic, weak) IBOutlet UITableView* table;
@property (nonatomic, strong) IBOutlet UITextField* texto;
@property (nonatomic, strong) IBOutlet UIButton* btnSearch;
@property (nonatomic, strong) IBOutlet UIView* viewMenu;
@property(nonatomic, strong) GADInterstitial *interstitial;
@end
