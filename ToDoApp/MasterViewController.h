//
//  MasterViewController.h
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class DetailViewController;
@class ToDoItemDataController;

@interface MasterViewController : CoreDataTableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) ToDoItemDataController *dataController;

- (IBAction)didSelectButton:(id)sender;

@end
