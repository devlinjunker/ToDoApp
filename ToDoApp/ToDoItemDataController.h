//
//  ToDoItemDataController.h
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ToDoItem;

@interface ToDoItemDataController : NSObject
{
    NSMutableArray *toDoList;
}

@property (nonatomic, copy) NSMutableArray *toDoList;

-(NSUInteger) countOfList;

-(ToDoItem *) objectInToDoListAtIndex: (NSInteger) index;

-(void)addToDoItemWithName:(NSString *)name Date: (NSDate *)date Description:(NSString *)description;

@end
