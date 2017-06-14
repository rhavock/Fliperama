#import "ReleaseDates.h"
#import "AlternativeNames.h"
#import "Screenshots.h"
#import "Videos.h"
#import "Cover.h"
#import "Esrb.h"
#import "Pegi.h"
#import "Genres.h"
#import "Themes.h"
#import "Keywords.h"
#import "GameModes.h"
#import "PlayerPerspectives.h"
#import "Publishers.h"
#import "Developers.h"
#import <UNIRest.h>
#import "PlatformGame.h"
#import <UIKit/UIKit.h>
@interface Game : NSObject
typedef enum TamanhoImagem{
    cover_small,
    screenshot_med,
    cover_big,
    logo_med,
    screenshot_big,
    screenshot_huge,
    thumb,
    micro
}TamanhoImagem;

@property (nonatomic, strong) NSNumber* id;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* slug;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSDate* created_at;
@property (nonatomic, strong) NSDate* updated_at;
@property (nonatomic, strong) NSString* summary;
@property (nonatomic, strong) NSString* storyline;
@property (nonatomic, strong) NSNumber *collection;
@property (nonatomic, strong) NSNumber *hypes;
@property (nonatomic, strong) NSNumber* rating;
@property (nonatomic, strong) NSNumber *popularity;
@property (nonatomic, strong) NSArray<Developers*>* developers;
@property (nonatomic, strong) NSArray<Publishers*>* publishers;
@property (nonatomic, strong) NSString* category;
@property (nonatomic, strong) NSArray<PlayerPerspectives*>* playerPerspective;
@property (nonatomic, strong) NSArray<GameModes*>* gameModes;
@property (nonatomic, strong) NSArray<Keywords*>* keywords;
@property (nonatomic, strong) NSArray<Themes*>* themes;
@property (nonatomic, strong) NSArray<Genres*>* genres;
@property (nonatomic, strong) NSDate* first_release_date;
@property (nonatomic, strong) NSArray<ReleaseDates*>* releasedates;
@property (nonatomic, strong) NSArray<AlternativeNames*>* alternativeNames;
@property (nonatomic, strong) NSArray<Screenshots*>* screenshots;
@property (nonatomic, strong) NSArray<Videos*> *videos;
@property (nonatomic, strong) Cover* cover;
@property (nonatomic, strong) NSArray<Esrb*>* esrb;
@property (nonatomic, strong) Pegi* pegi;
@property (nonatomic, strong) PlatformGame* platformGame;
@property (nonatomic, strong) UIImage *imageBack;

-(void)loadGamesById:(NSNumber*)id callback:(void(^)(Game* game))callback;
-(void)loadGames:(void(^)(NSArray<Game*>* games))callback;
-(void)loadGamesByName:(NSString*)search callback:(void(^)(NSArray<Game*>* games))callback;
-(void)loadGamesBySort:(NSString*)sort callback:(void(^)(NSArray<Game*>* games))callback;
-(void)loadGamesByGenreSortLimit:(NSString*)filter limit:(NSString*)limit sort:(NSString*)sort callback:(void(^)(NSArray<Game*>* games))callback;
- (void)imageUrl:(NSString *)stringimagem tamanhoImagem:(TamanhoImagem)tamanhoImagem retornoImagem:(void(^)(UIImage* image))retornoImagem;
@end
