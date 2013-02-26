//
//  ToDoItemCell.h
//  ToDoApp
//
//  Created by Devlin Junker on 2/5/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@property (nonatomic, weak) IBOutlet UIButton *doneButton;

@end
