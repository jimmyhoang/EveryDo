//
//  DetailViewController.h
//  EveryDo
//
//  Created by Jimmy Hoang on 2017-06-13.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

