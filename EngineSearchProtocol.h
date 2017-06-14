
@protocol EngineSearchProtocol <NSObject>

-(void)executeSearch:(NSString*)searchText executionBlock:(void(^)(NSArray* response))executionBlock;

@end
