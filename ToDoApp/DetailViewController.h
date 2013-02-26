//
//  DetailViewController.h
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItemDB.h"

@class ToDoItemDB;

@interface DetailViewController : UITableViewController

@property (nonatomic, strong) ToDoItemDB *item;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end
