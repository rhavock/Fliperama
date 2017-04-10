#import <Foundation/Foundation.h>
#import <sqlite3.h>

// database name demo.sqlite

#define DB_NAME @"Fliperama.sqlite"

@interface DBConnection : NSObject
{
@private sqlite3 *g_database;
}

@property (nonatomic,assign,readwrite) sqlite3 *database;

+ (DBConnection *) sharedConnection;
+ (BOOL) executeQuery:(NSString *)query;
+ (NSMutableArray *) fetchResults:(NSString *)query;
+ (int) rowCountForTable:(NSString *)table where:(NSString *)where;
+ (void) errorMessage:(NSString *)msg;
+ (void) closeConnection;

- (id)initConnection;
- (void)close;

@end
