//
//  NotesViewController.m
//  LifeNotes
//
//  Created by amemon on 1/29/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import "AddNoteCell.h"
#import "AddNoteCommand.h"
#import "Note.h"
#import "NoteCell.h"
#import "NoteStore.h"
#import "NotesViewController.h"
#import "RemoveNoteCommand.h"
#import "Tag.h"

@interface NotesViewController ()

@property (weak, nonatomic) UITextField* addNoteTextField;
@property (weak, nonatomic) UIButton* addNoteDoneButton;


- (IBAction)addNoteDoneTap:(id)sender;

@end

@implementation NotesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NoteStore.defaultStore.allNotes.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* AddNoteCellIdentifier = @"addNoteCell";
    static NSString* CellIdentifier = @"noteCell";
    
    NSString* cellId = indexPath.row == 0 ? AddNoteCellIdentifier : CellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        AddNoteCell* addNoteCell = (AddNoteCell*)cell;
        self.addNoteTextField = addNoteCell.addNoteTextField;
        self.addNoteDoneButton = addNoteCell.addNoteDoneButton;
        self.addNoteTextField.keyboardType = UIKeyboardTypeTwitter;
        self.addNoteTextField.returnKeyType = UIReturnKeyDone;
    }
    else
    {
        NoteCell* noteCell = (NoteCell*)cell;
        Note* n = [NoteStore.defaultStore.allNotes objectAtIndex:indexPath.row - 1];
        noteCell.noteTextView.text = n.noteName;
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row > 0;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [RemoveNoteCommand performWithIndex:indexPath.row - 1];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        self.addNoteTextField.hidden = NO;
        self.addNoteDoneButton.hidden = NO;
        [self.addNoteTextField becomeFirstResponder];
    }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)addNoteDoneTap:(id)sender
{
    [AddNoteCommand performWithString:self.addNoteTextField.text];
    self.addNoteTextField.text = @"";
    [self.tableView reloadData];
}
@end
