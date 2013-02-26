//
//  AddToDoItemViewController.h
//  ToDoApp
//
//  Created by Devlin Junker on 1/20/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddToDoItemViewControllerDelegate;

@interface AddToDoItemViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <AddToDoItemViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *dueDateInput;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextView *descriptionInput;
- (IBAction)finishNewItem:(id)sender;
- (IBAction)cancelNewItem:(id)sender;

@end

@protocol AddToDoItemViewControllerDelegate <NSObject>

-(void) addToDoItemViewDidCancel:(AddToDoItemViewController *)controller;

-(void) addToDoItemViewDidFinish:(AddToDoItemViewController *)controller Name:(NSString *)name Date:(NSDate *)date Description:(NSString *)description;

@end