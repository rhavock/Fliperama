
@interface ReleaseDates : NSObject

@property (nonatomic, strong) NSString* category;
@property (nonatomic, strong) NSString* platform;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, strong) NSString* region;
@property (nonatomic, strong) NSString* human;
@property (nonatomic, strong) NSNumber* releaseyear;
@property (nonatomic, strong) NSString* releasemonth;

@end
