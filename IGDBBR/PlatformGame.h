//#import "Game.h"

@class Game;
@interface PlatformGame : NSObject

@property (nonatomic, strong)NSNumber* id;
@property (nonatomic, strong)NSString* name;
@property (nonatomic, strong)NSString* slug;
@property (nonatomic, strong)NSString* url;
@property (nonatomic, strong)NSString* alternativeName;
@property (nonatomic, strong)NSArray* games;
@property (nonatomic) int offset;
@property (nonatomic, strong) NSMutableArray *platforms;

-(Game*)getPlatformByGameId:(Game*)game;
-(NSArray*)getPlatformByGameIdBase:(int)offSet;
@end
