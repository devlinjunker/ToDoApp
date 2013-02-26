//
//  ToDoItemDB.h
//  ToDoApp
//
//  Created by Devlin Junker on 2/15/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ToDoList.h"


@interface ToDoItemDB : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) ToDoList *list;

@end
