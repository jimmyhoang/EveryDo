//
//  MasterViewController.m
//  EveryDo
//
//  Created by Jimmy Hoang on 2017-06-13.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "TodoTableViewCell.h"
#import "AddItemViewController.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate, AddItemViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray* todoList;
@property (nonatomic, strong) NSMutableArray* completedList;
@property (nonatomic, strong) NSIndexPath* currentlySelectedIndex;
@property (nonatomic, assign) NSInteger currentSection;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Todo* item1 = [[Todo alloc] init];
    item1.title = @"Buy Milk";
    item1.todoDescription = @"Go to the store and buy some milk";
    item1.priorityNumber = 2;
    item1.isCompletedIndicator = NO;
    item1.deadline = [NSDate date];
    
    Todo* item2 = [[Todo alloc] init];
    item2.title = @"Buy Cookies";
    item2.todoDescription = @"Purchase some delicious cookies from the grocery mart";
    item2.priorityNumber = 4;
    item2.isCompletedIndicator = NO;
    item2.deadline = [NSDate date];
    
    Todo* item3 = [[Todo alloc] init];
    item3.title = @"Wash the car";
    item3.todoDescription = @"Wash the car real good";
    item3.priorityNumber = 3;
    item3.isCompletedIndicator = NO;
    item3.deadline = [NSDate date];
    
    Todo* item4 = [[Todo alloc] init];
    item4.title = @"Buy new clothes";
    item4.todoDescription = @"Hit up the mall and find some new swag";
    item4.priorityNumber = 1;
    item4.isCompletedIndicator = NO;
    item4.deadline = [NSDate date];
    
    Todo* item5 = [[Todo alloc] init];
    item5.title = @"Walk the dog";
    item5.todoDescription = @"Walk little J";
    item5.priorityNumber = 1;
    item5.isCompletedIndicator = NO;
    item5.deadline = [NSDate date];
    
    self.todoList = [NSMutableArray arrayWithObjects:item1,item2,item3,item4,item5, nil];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(crossOffItem:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:swipeGesture];
}


- (void)viewWillAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Swipe Gesture Action

-(void)crossOffItem:(UISwipeGestureRecognizer*)sender {
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    Todo* itemToBeCrossed = self.todoList[indexPath.row];
    itemToBeCrossed.isCompletedIndicator = YES;
    
    if (!self.completedList) {
        self.completedList = [[NSMutableArray alloc] initWithObjects:itemToBeCrossed, nil];
    } else {
        [self.completedList addObject:itemToBeCrossed];
    }

    [self.todoList removeObject:itemToBeCrossed];
    [self.tableView reloadData];
}


#pragma mark - Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentlySelectedIndex = indexPath;
    self.currentSection = indexPath.section;
    
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)addItemViewController:(AddItemViewController *)controller addItem:(Todo *)item {
    
    [self.todoList addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.todoList count] - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addItemViewControllerDidCancel:(AddItemViewController *)controller {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        
        switch (self.currentSection) {
            case 0:
            {
                Todo* item = self.todoList[self.currentlySelectedIndex.row];
                DetailViewController *controller = segue.destinationViewController;
                [controller setDetailItem:item];
                break;
            }
            case 1:
            {
                Todo* item = self.completedList[self.currentlySelectedIndex.row];
                DetailViewController *controller = segue.destinationViewController;
                [controller setDetailItem:item];
                break;
            }
        }

    }
    
    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddItemViewController *addItemVC = [navigationController viewControllers][0];
        addItemVC.delegate = self;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.todoList.count;
    }
    
    if (section == 1) {
        return self.completedList.count;
    }
    
    return 0;
    
}


- (TodoTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch (indexPath.section) {
        case 0:
        {
            Todo* item = self.todoList[indexPath.row];
            cell.descriptionLabel.text = item.todoDescription;
            cell.todoItemLabel.text = item.title;
            cell.priorityLabel.text = [NSString stringWithFormat:@"%li",(long)item.priorityNumber];
            cell.isCompleted = item.isCompletedIndicator;
            break;
        }
        case 1:
        {
            if (!self.completedList) {
                break;
            } else {
                Todo* item = self.completedList[indexPath.row];
                cell.descriptionLabel.text = item.todoDescription;
                cell.todoItemLabel.text = item.title;
                cell.priorityLabel.text = [NSString stringWithFormat:@"%li",(long)item.priorityNumber];
                cell.isCompleted = item.isCompletedIndicator;
                break;
            }

        }
    }
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todoList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    switch (sourceIndexPath.section) {
        case 0:
        {
            Todo* itemToMove = [self.todoList objectAtIndex:sourceIndexPath.row];
            [self.todoList removeObjectAtIndex:sourceIndexPath.row];
            [self.todoList insertObject:itemToMove atIndex:destinationIndexPath.row];
        }
        case 1:
        {
            Todo* itemToMove = [self.completedList objectAtIndex:sourceIndexPath.row];
            [self.completedList removeObjectAtIndex:sourceIndexPath.row];
            [self.completedList insertObject:itemToMove atIndex:destinationIndexPath.row];
        }
    }
    

    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Outstanding Items";
    } else if (section == 1) {
        return @"Completed Items";
    } else {
        return @"";
    }
}

#pragma mark - Segmented Button Action
- (IBAction)segmentedButton:(UISegmentedControl*)sender {
    NSString* key;
    
    if (sender.selectedSegmentIndex == 0) {
        key = @"priorityNumber";
    } else {
        key = @"deadline";
    }
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    NSArray* sortedArray = [self.todoList sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    self.todoList = [NSMutableArray arrayWithArray:sortedArray];
    [self.tableView reloadData];   
}



@end
