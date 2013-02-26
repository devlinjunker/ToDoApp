//
//  ToDoItemDataController.m
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import "ToDoItemDataController.h"
#import "ToDoItem.h"

@interface ToDoItemDataController()
-(void) initializeDefaultDataList;
@end

@implementation ToDoItemDataController
@synthesize toDoList = _toDoList;

/* 
 Initializes ToDoList with Default Item, Called at Data Controller Init
*/
-(void) initializeDefaultDataList
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    self.toDoList = list;
    
    [self addToDoItemWithName:@"First Item" Date:[NSDate dateWithTimeIntervalSinceNow:86400] Description:@"Delete This Item"];
}

/* 
 Sets the ToDoList 
*/
-(void) setToDoList:(NSMutableArray *)list
{
    if(_toDoList != list)
    {
        _toDoList = [list mutableCopy];
    }
}

/* 
 Initializes DataController Creates Default ToDoList and Returns Self
*/
-(id) init
{
    self = [super init];
    
    if(self)
    {
        [self initializeDefaultDataList];
        
        return self;
    }
    
    return nil;
}

/*
 Returns the Size of ToDoList
*/
-(NSUInteger) countOfList
{
    return [self.toDoList count];
}

/*
 Returns the ToDoItem at the specified location
*/
-(ToDoItem *) objectInToDoListAtIndex:(NSInteger)index
{
    return [self.toDoList objectAtIndex:index];
}

/*
 Adds a new ToDoItem to the ToDoList
*/
-(void) addToDoItemWithName:(NSString *)name Date:(NSDate *)date Description:(NSString *)description
{
    ToDoItem *newItem;
    
    newItem = [[ToDoItem alloc] initWithName:name DueDate:date Description:description];
    
    [self.toDoList addObject:newItem];
}

@end
