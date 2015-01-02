//
//  BrownBagLists.m
//  Signature
//
//  Created by Shaoke Xu on 12/30/14.
//  Copyright (c) 2014 Shaoke Xu. All rights reserved.
//

#import "BrownBagLists.h"
#import "DBManager.h"
#import "appConfig.h"


@interface BrownBagLists(){
    
}

@end

@implementation BrownBagLists

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.driveService = [[GTLServiceDrive alloc] init];
    
    // Get stored credentials
    GTMOAuth2Authentication *credentials;
    credentials = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                                        clientID:kClientID
                                                                    clientSecret:kClientSecret];
    
    self.driveService.authorizer = credentials;
    
    // If it didn't authorize before
    if (![credentials canAuthorize]) {
        GTMOAuth2ViewControllerTouch *authController;
        authController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeDriveFile
                                                                    clientID:kClientID
                                                                clientSecret:kClientSecret
                                                            keychainItemName:kKeychainItemName
                                                                    delegate:self
                                                            finishedSelector:@selector(viewController:finishedWithAuth:error:)];
        [self presentViewController:authController animated:YES completion:nil];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@", paths[0]);
    
    // [self createAppRootFolder];
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error{
    if (error != nil) {
        //
    }else{
        self.driveService.authorizer = authResult;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self initApp];
    }
}

// TODO
- (BOOL)isInitedBefore{
    
    return NO;
}

- (void)initApp{
    // create application root folder in Disk
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *appPath = [paths objectAtIndex:0];
    NSLog(@"appPath = %@", appPath);
    [self createDirectory:APPROOTFOLDER atFilePath:appPath];
    
    GTLDriveFile *folder = [GTLDriveFile object];
    folder.title = APPROOTFOLDER;
    folder.mimeType = @"application/vnd.google-apps.folder";
    
    // Upload application root folder to Google Drive
    GTLQueryDrive *query = [GTLQueryDrive queryForFilesInsertWithObject:folder uploadParameters:nil];
    [self.driveService executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLDriveFile *updatedFile, NSError *error){
        if (error == nil) {
            NSLog(@"Created Folder");
            [self initAppDatabase];
        }else{
            NSLog(@"An error occurred: %@", error);
        }
    }];

}

- (void)initAppDatabase{
    [DBManager getSharedInstance];
}

-(void)createDirectory:(NSString *)directoryName atFilePath:(NSString *)filePath
{
    NSString *filePathAndDirectory = [filePath stringByAppendingPathComponent:directoryName];
    NSError *error;
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:filePathAndDirectory
                                   withIntermediateDirectories:NO
                                                    attributes:nil
                                                         error:&error])
    {
        NSLog(@"Create directory error: %@", error);
    }
}

@end
