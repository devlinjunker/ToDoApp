//
//  ToDoList.h
//  ToDoApp
//
//  Created by Devlin Junker on 2/15/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ToDoItemDB;

@interface ToDoList : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *items;
@end

@interface ToDoList (CoreDataGeneratedAccessors)

- (void)addItemsObject:(ToDoItemDB *)value;
- (void)removeItemsObject:(ToDoItemDB *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
