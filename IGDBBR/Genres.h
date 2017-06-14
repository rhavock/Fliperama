@interface Genres : NSObject

@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* name;

-(void)getGenreById:(NSString*)id callback:(void(^)(Genres* genre))callback;
-(void)getGenreByName:(NSString*)genreString callback:(void(^)(NSString* response))callback;
@end
