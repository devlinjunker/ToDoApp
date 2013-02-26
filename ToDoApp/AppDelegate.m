//
//  AppDelegate.m
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import "AppDelegate.h"
#import "ToDoItemDataController.h"
#import "MasterViewController.h"
#import "ToDoItemDB.h"
#import "ToDoList.h"

@implementation AppDelegate

@synthesize database = _database;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    UINavigationController *navContoller = (UINavigationController *)self.window.rootViewController;
    
    MasterViewController *masterController = (MasterViewController *)[[navContoller viewControllers] objectAtIndex:0];
    
    ToDoItemDataController *dataController = [[ToDoItemDataController alloc] init];
    
    masterController.dataController = dataController;
    
    // Connecting to Database
    NSURL* documentURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"database"];
    
    self.database = [[UIManagedDocument alloc] initWithFileURL:documentURL ];
    
    if( [[NSFileManager defaultManager] fileExistsAtPath:self.database.fileURL.path] )
    { // Open Existing Database
        NSLog(@"Checking Saved Data");
        [self.database openWithCompletionHandler:^(BOOL success){
            if( !success ){
                NSLog(@"Error: %d", self.database.documentState);
            }
            else{
                NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItemDB"];
                
                fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES]];
                
                // Filter
                //fetch.predicate = [NSPredicate predicateWithFormat:@"name == %@", @"3"];
                
                NSError *e = nil;
                
                NSArray *fetchedItems = [self.database.managedObjectContext executeFetchRequest:fetch error:&e];
                
                if(!e){
                    NSLog(@"Fetched Data: %@", fetchedItems);
                }

            }
        }];
        
    } // Create New Database
    else{
        NSLog(@"Initial Save");
        [self.database saveToURL:self.database.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            
            for(int i = 0; i < 5; i++){
                ToDoItemDB *newToDoItem = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItemDB" inManagedObjectContext:self.database.managedObjectContext];
            
                
                newToDoItem.name = [NSString stringWithFormat:@"%d",i ];
                
                newToDoItem.dueDate = [NSDate dateWithTimeIntervalSinceNow:86400];
        
            }
            
            NSLog(@"%@ %@ %@", self.database, self.database.fileURL, self.database.fileType);
            
            // Explicity call Save
            
            [self.database saveToURL:self.database.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
                
                if(success){
                    NSLog(@"Saved Database");
                    
                    // Query for an Object
                    
                    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItemDB"];
                    
                    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES]];
                    
                    NSError *e = nil;
                    
                    NSArray *allItems = [self.database.managedObjectContext executeFetchRequest:fetch error:&e];
                    
                    if(!e){
                        NSLog(@"Objects: %@", allItems);
                    }
                    
                }else{
                    
                    NSLog(@"%d", self.database.documentState);
                }
                
            }];
            
            
            
        }];
        
        
    }
    
    
    return YES;
    /*
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    return YES;
    */
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 Returns the URL to the application's Documents directory.
*/
- (NSURL *)applicationDocumentsDirectory
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
        
    return [NSURL fileURLWithPath:documentPath];
}
                     
@end
