#import <UIKit/UIKit.h>
#import "Game.h"
@interface ListaViewCell: UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel* releaseDate;
@property (nonatomic, weak)IBOutlet UILabel* name;
@property (nonatomic, weak)IBOutlet UILabel* genero;
@property (nonatomic, weak)IBOutlet UIImageView *imagem;
@property (nonatomic, weak)IBOutlet UILabel* platform;
@property (nonatomic, weak)Game* game;
@property (nonatomic, weak)IBOutlet UIActivityIndicatorView *loadingImage;
@property (nonatomic, weak)IBOutlet UIImageView *imgBack;
@property (nonatomic, weak)IBOutlet UILabel *rating;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView* loading;
-(void)setInfo:(Game*)game;
@end
