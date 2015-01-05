//
//  DBManager.m
//  Signature
//
//  Created by Shaoke Xu on 12/31/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
#import "appConfig.h"
#import "BrownBag.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@interface DBManager()

@property(nonatomic, strong) NSString *documentsDirectory;
@property(nonatomic, strong) NSString *databaseFilename;
@property(nonatomic) const char *databasePath;

- (BOOL)initDB;

@end

@implementation DBManager

+(DBManager *)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
        [sharedInstance initDB];
    }
    return sharedInstance;
}

- (id)init{
    if (self = [super init]) {
        _databaseFilename = APPDATABASEFILENAME;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:APPROOTFOLDER];
    }
    NSLog(@"DBManager -> init, self.documentsDirectory = %@", self.documentsDirectory);
    return self;
}

-(BOOL)initDB{

    BOOL isSuccess = YES;
    
    _databasePath = [[self.documentsDirectory stringByAppendingPathComponent:_databaseFilename] UTF8String];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:[NSString stringWithUTF8String:_databasePath]]) {
        if (sqlite3_open(_databasePath, &database) == SQLITE_OK) {
            
            char *errMsg;
            // Create brown bag list table
            const char *brown_bag_list_sql_stmt = "CREATE TABLE IF NOT EXISTS brown_bag_list(id integer PRIMARY KEY AUTOINCREMENT NOT NULL, topic text NOT NULL,scheduled_date integer,status integer DEFAULT(0),create_date integer NOT NULL,speaker text,description text,finished_date integer,signature_images_path text,signature_pdf_path text,attend_people_number integer DEFAULT(0))";
            
            if(sqlite3_exec(database, brown_bag_list_sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Create brown_bag_list table successful!");
            }else{
                NSLog(@"Create brown_bag_list table fail! error message: %s", errMsg);
            }
            
            // Create signature_images table
            const char *signature_images_sql_stmt = "CREATE TABLE signature_images (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,brown_bag_id integer NOT NULL,name text NOT NULL,image_name text NOT NULL,image_path text NOT NULL,image_created_date integer NOT NULL,image_update_date integer NOT NULL)";
            
            if (sqlite3_exec(database, signature_images_sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Create signature_images table successful!");
            }else{
                NSLog(@"Create signature_images table fail! error message: %s", errMsg);
            }
            
            sqlite3_close(database);
            NSLog(@"Create database %@ successful!", _databaseFilename);
            isSuccess = YES;
        }else{
            NSLog(@"Create database %@ error!", _databaseFilename);
            isSuccess = NO;
        }
    }else{
        NSLog(@"Database is existing");
    }
    return isSuccess;
}

- (NSArray *)getBrownBagLists:(NSInteger)status{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *selectSQL;
    const char *sql_stmt;
    
    if (status==-1) {
        sql_stmt = "SELECT * FROM brown_bag_list";
    }else{
        selectSQL = [NSString stringWithFormat:@"SELECT * FROM brown_bag_list WHERE status=%.0ld", status];
        sql_stmt = [selectSQL UTF8String];
    }
    _databasePath = [[self.documentsDirectory stringByAppendingPathComponent:_databaseFilename] UTF8String];
    if(sqlite3_open(_databasePath, &database) == SQLITE_OK){
        if (sqlite3_prepare_v2(database, sql_stmt, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                BrownBag *brownBag = [[BrownBag alloc] init];
                brownBag.ID = sqlite3_column_int(statement, 0);
                brownBag.topic = [NSString stringWithUTF8String:(const char *)sqlite3_column_value(statement, 1)];
                // set scheduleDate, default value is NULL
                if (sqlite3_column_int(statement, 2)) {
                    brownBag.scheduledDate = [NSDate dateWithTimeIntervalSince1970:sqlite3_column_int(statement, 2)];
                }else{
                    brownBag.scheduledDate = nil;
                }
                
                // set status
                brownBag.status = sqlite3_column_int(statement, 3);
                
                // set create date, default value is NULL
                if (sqlite3_column_int(statement, 4)) {
                    brownBag.createdDate = [NSDate dateWithTimeIntervalSince1970:sqlite3_column_int(statement, 4)];
                }else{
                    brownBag.createdDate = nil;
                }
                
                // set speader
                brownBag.speaker = [NSString stringWithUTF8String:(const char *)sqlite3_column_value(statement, 5)];

                // set topic description
                brownBag.topicDescription = [NSString stringWithUTF8String:(const char *)sqlite3_column_value(statement, 6)];
                
                // set finish date, default value is NULL
                if (sqlite3_column_int(statement, 7)) {
                    brownBag.finishedDate = [NSDate dateWithTimeIntervalSince1970:sqlite3_column_int(statement, 7)];
                }else{
                    brownBag.finishedDate = nil;
                }
                
                // set signature image path
                brownBag.signatureImagesPath = [NSString stringWithUTF8String:(const char *)sqlite3_column_value(statement, 8)];
                
                // set signature pdf path
                brownBag.signaturePdfPath = [NSString stringWithUTF8String:(const char *)sqlite3_column_value(statement, 9)];
                
                // set attend people number
                brownBag.attendPeopleNumber = sqlite3_column_int(statement, 10);
                
                [result addObject:brownBag];
            }
        }
    }
    
    NSLog(@"%@", result);
    
    return result;
}

- (NSInteger)createABrownBag:(NSString *)topic scheduledDate:(NSInteger)scheduledDate speaker:(NSString *)speaker description:(NSString *)description{
    
    NSInteger brownBagID = -1;
    
    sqlite3_stmt *statement;
    
    NSString *insertSQL= [NSString stringWithFormat: @"INSERT INTO brown_bag_list(topic, scheduled_date, status, create_date, speaker, description) VALUES (\"%@\", \"%.0ld\", \"%.0d\", \"%.0ld\", \"%@\", \"%@\")", topic, (long)scheduledDate, 0 ,(long)[[NSDate date] timeIntervalSince1970], speaker, description];
    const char *sql_stmt = [insertSQL UTF8String];
    
    _databasePath = [[self.documentsDirectory stringByAppendingPathComponent:_databaseFilename] UTF8String];
    if (sqlite3_open(_databasePath, &database) == SQLITE_OK) {
        sqlite3_prepare_v2(database, sql_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            brownBagID = sqlite3_last_insert_rowid(database);
            NSLog(@"insert success, id = %ld", (long)brownBagID);
        }else{
            brownBagID = -1;
            NSLog(@"Insert fail");
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }else{
        NSLog(@"database path = %@", [NSString stringWithUTF8String:_databasePath]);
        NSLog(@"error: %@", [NSString stringWithUTF8String:sqlite3_errmsg(database)]);
        NSLog(@"Open database fail");
    }
    
    return brownBagID;
}

@end
