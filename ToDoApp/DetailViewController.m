//
//  DetailViewController.m
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import "DetailViewController.h"
#import "ToDoItemDB.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController
@synthesize item = _item, nameLabel = _nameLabel, descriptionLabel = _descriptionLabel, dateLabel = _dateLabel;

#pragma mark - Managing the detail item

/*
 Set the Detail View ToDoitem
*/
- (void)setItem:(ToDoItemDB *)newItem
{
    if (_item != newItem) {
        _item = newItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

/*
 Adds the ToDoItem Details to the View
*/
- (void)configureView
{
    // Pointer to ToDoItem
    ToDoItemDB *toDo = self.item;
    
    // Create Date Formatter
    static NSDateFormatter *dateFormatter = nil;
    if( dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    
    if( toDo )
    {
        self.nameLabel.text = toDo.name;

        self.descriptionLabel.text = toDo.description;
        
        self.dateLabel.text = [dateFormatter stringFromDate:(NSDate *)toDo.dueDate];
        
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Setup View from ToDoItem Details
    [self configureView];
}

-(void)viewDidUnload
{
    self.item = nil;
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
