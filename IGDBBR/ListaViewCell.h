#import <UIKit/UIKit.h>
#import "Game.h"
@interface ListaViewCell: UITableViewCell

@property (nonatomic, weak)IBOutlet UILabel* releaseDate;
@property (nonatomic, weak)IBOutlet UILabel* name;
@property (nonatomic, weak)IBOutlet UILabel* genero;
@property (nonatomic, weak)IBOutlet UIImageView *imagem;
@property (nonatomic, weak)IBOutlet UILabel* platform;
@property (nonatomic, weak)IBOutlet UILabel* nota;
@property (nonatomic, weak)Game* game;
@property (nonatomic, weak)IBOutlet UIActivityIndicatorView *loadingImage;
-(void)setInfo:(Game*)game;
@end
