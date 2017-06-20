@interface Genres : NSObject

@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* name;

-(NSString*)getGenreById:(NSString *)generoID;
-(void)getGenreByName:(NSString*)genreString callback:(void(^)(NSString* response))callback;
@end
