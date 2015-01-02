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

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;

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
        self.databaseFilename = APPDATABASEFILENAME;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:APPROOTFOLDER];
    }
    NSLog(@"DBManager -> init, self.documentsDirectory = %@", self.documentsDirectory);
    return self;
}

-(BOOL)initDB{

    BOOL isSuccess = YES;
    
    NSString *databasePath = [[NSString alloc] initWithString:[self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename]];
    self.databasePath = [databasePath UTF8String];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:databasePath]) {
        if (sqlite3_open(self.databasePath, &database) == SQLITE_OK) {
            
            char *errMsg;
            // Create brown bag list table
            const char *brown_bag_list_sql_stmt = "CREATE TABLE IF NOT EXISTS brown_bag_list(id integer PRIMARY KEY AUTOINCREMENT NOT NULL, topic text NOT NULL,scheduled_date integer,speaker text,description text,finished_date integer,signature_images_path text,signature_pdf_path text,attend_people_number integer DEFAULT(0))";
            
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
            NSLog(@"Create database %@ successful!", self.databaseFilename);
            isSuccess = YES;
        }else{
            NSLog(@"Create database %@ error!", self.databaseFilename);
            isSuccess = NO;
        }
    }else{
    }
    return isSuccess;
}

- (NSDictionary *)getBrownBagLists:(NSInteger)status{
    NSDictionary *result = @{@"result":@[]};
    
    return result;
}

@end
