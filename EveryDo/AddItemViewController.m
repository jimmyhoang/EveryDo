//
//  AddItemViewController.m
//  EveryDo
//
//  Created by Jimmy Hoang on 2017-06-13.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons

- (IBAction)cancel:(id)sender {
    [self.delegate addItemViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    
    Todo* item = [[Todo alloc] init];
    item.title = self.titleTextField.text;
    item.todoDescription = self.descriptionTextField.text;
    item.priorityNumber = [self.priorityTextField.text integerValue];
    
    [self.delegate addItemViewController:self addItem:item];
}

 
@end
