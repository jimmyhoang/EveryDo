//
//  DetailViewController.h
//  EveryDo
//
//  Created by Jimmy Hoang on 2017-06-13.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Todo* detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;

@end

