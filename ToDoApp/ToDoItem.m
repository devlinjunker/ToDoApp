//
//  ToDoItem.m
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

@synthesize name = _name, description = _description, dueDate = _dueDate, complete = _complete;


-(id) initWithName:(NSString *)newName DueDate:(NSDate *)date Description:(NSString *)newDescription 
{
    self = [super init];
    
    if(self)
    {
        _name = newName;
        
        _description = newDescription;
        
        _dueDate = date;
        
        _complete = FALSE;
        
        return self;
    }
    
    return nil;
}

@end
