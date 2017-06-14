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

    // Tap gesture recognizer to dismiss keyboard
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tap Gesture Action

-(void)dismissKeyboard:(UITapGestureRecognizer*)sender {
    [self.view endEditing:YES];
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
    item.deadline = self.deadlinePicker.date;
    
    [self.delegate addItemViewController:self addItem:item];
}

 
@end
