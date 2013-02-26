//
//  ToDoItemCell.m
//  ToDoApp
//
//  Created by Devlin Junker on 2/5/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import "ToDoItemCell.h"

@implementation ToDoItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization Code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
