
@interface Defaults : NSObject

+(void)addDefaults:(NSObject*)value
              name:(NSString*)name;

+(NSObject*)getDefaults:(NSString*)keyName;

+(NSString*)getArchiveDefault:(NSString*)keyName;
@end
