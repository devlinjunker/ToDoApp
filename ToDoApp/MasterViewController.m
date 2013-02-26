//
//  MasterViewController.m
//  ToDoApp
//
//  Created by Devlin Junker on 1/19/13.
//  Copyright (c) 2013 Devlin Junker. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AddToDoItemViewController.h"

#import "AppDelegate.h"

#import "ToDoItemCell.h"

#import "ToDoItemDB.h"

#import "ToDoItem.h"
#import "ToDoItemDataController.h"

@interface MasterViewController ()<AddToDoItemViewControllerDelegate>

@end

/*
@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end
*/
 
@implementation MasterViewController

@synthesize dataController = _dataController;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    /* Create Fetch Request */
    
    NSFetchRequest* fetchByDate = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItemDB"];
    
    fetchByDate.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES]];
    
    AppDelegate *mainDelegate = [UIApplication sharedApplication].delegate;
    
    NSFetchedResultsController *fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchByDate managedObjectContext:mainDelegate.database.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = fetchController;
    
    /*// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
 */

#pragma mark - Table View

/*
 Sets the Number of Sections in the Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
*/
/*
 Sets the Number of Rows in the Section (Only one Section for Now)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}
*/


/* 
 Sets info to be displayed in the Cell at given indexPath
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Identifier based on Storyboard */
    static NSString *identifier = @"ToDoCell";
    
    // Create Date Formatter
    static NSDateFormatter *dateFormatter = nil;
    if( dateFormatter == nil )
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    
    // Get Cell with Identifier at the indexPath
    ToDoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    CALayer *buttonLayer = [cell.doneButton layer];
    
    [buttonLayer setBorderWidth:1.0];
    [buttonLayer setCornerRadius:5.0];
    [buttonLayer setBorderColor:[[UIColor grayColor] CGColor]];
    
    // Get ToDoItem at corresponding indexPath in Array
//    ToDoItem *toDoItematIndex = [self.dataController objectInToDoListAtIndex:indexPath.row];
  
    ToDoItemDB *toDoItematIndex = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Set TextLabel Text to ToDoItem Name
    cell.nameLabel.text = [toDoItematIndex name];
    
    // Set Detail Text to ToDoItem Date
    [[cell dateLabel] setText:[dateFormatter stringFromDate:(NSDate *)toDoItematIndex.dueDate]];
    
    // Return Cell
    return cell;
}

/*
 Dictates whether cell at given indexPath is editable
*/
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (IBAction)didSelectButton:(id)sender {
    ToDoItemCell *cell = (ToDoItemCell*)[[sender superview] superview];
    
    UIButton * button = (UIButton*) sender;
    
    button.selected = !button.selected;
    
   // [cell.nameLabel setAttributedText:[[NSAttributedString alloc] initWithString:[cell.nameLabel tfext] attributes:]
    
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    NSLog(@"%d", index.row);
}

/*
 When row is selected, this function is called
*/
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {

        // Get the ToDoItem for this indexPath from Array
//        ToDoItem *object = [self.dataController objectInToDoListAtIndex:indexPath.row];
  
        // Get the ToDoItem out of the database
        
        ToDoItemDB *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        
        // Sets the DetailViewController Item to the ToDoItem
        self.detailViewController.item = object;
    }
}

/*
 Called When Segue as Specified by Storyboard is Happening
*/
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // If ShowToDoDetail Seque
    if ([[segue identifier] isEqualToString:@"showToDoDetails"])
    {
        // Get IndexPath
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        
        // Get ToDoItem of IndexPath in Array
//        ToDoItem *object = [self.dataController objectInToDoListAtIndex:index.row];
        
        ToDoItemDB *object = [self.fetchedResultsController objectAtIndexPath:index];
        
        // Get the View Controller being Segued to
        DetailViewController *detailController = [segue destinationViewController];
        
        //Set the DetailViewController Item to the ToDoItem
        detailController.item = object;
    
    }
    else if( [[segue identifier] isEqualToString:@"showAddToDo"] )
    {
        // Create AddItemViewController
        AddToDoItemViewController *addController = (AddToDoItemViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        
        // Set This to AddItemViewControllers Delegate
        addController.delegate = self;
    }
}

#pragma AddToDoItemViewControllerDelegate

/*
 Called if Add Item was Canceled
*/
-(void) addToDoItemViewDidCancel:(AddToDoItemViewController *)controller
{
    // Remove the AddItemViewController
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/*
 Called if Add Item was Completed
*/
-(void) addToDoItemViewDidFinish:(AddToDoItemViewController *)controller Name:(NSString *)name Date:(NSDate *)date Description:(NSString *)description
{
    // If there is a name
    if( [name length] )
    {
        // Add Item to ToDoList
        [self.dataController addToDoItemWithName:name Date:date Description:description];

        // Reload the Table ToDoList Data
        [self.tableView reloadData];
    }
    
    // Remove the AddItemViewController
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
