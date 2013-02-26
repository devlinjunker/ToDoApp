//
//  ToDoItem.h
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, strong) NSDate *dueDate;
@property (nonatomic) BOOL complete;

-(id) initWithName:(NSString *)name DueDate:(NSDate *)date Description:(NSString *)description;

@end
