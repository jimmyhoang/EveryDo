//
//  AddItemViewController.h
//  EveryDo
//
//  Created by Jimmy Hoang on 2017-06-13.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"
@class AddItemViewController;

@protocol AddItemViewControllerDelegate <NSObject>

-(void)addItemViewControllerDidCancel:(AddItemViewController*)controller;
-(void)addItemViewController:(AddItemViewController*)controller addItem:(Todo*)item;

@end

@interface AddItemViewController : UITableViewController

@property (nonatomic, weak) id <AddItemViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *deadlinePicker;


- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
