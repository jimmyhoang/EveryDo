//
//  TodoTableViewCell.m
//  EveryDo
//
//  Created by Jimmy Hoang on 2017-06-13.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import "TodoTableViewCell.h"

@implementation TodoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    if (self.isCompleted == YES) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.todoItemLabel.text];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        self.todoItemLabel.attributedText = attributeString;
        
        attributeString = [[NSMutableAttributedString alloc] initWithString:self.descriptionLabel.text];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        self.descriptionLabel.attributedText = attributeString;
        
        attributeString = [[NSMutableAttributedString alloc] initWithString:self.priorityLabel.text];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        self.priorityLabel.attributedText = attributeString;
    }
}


@end
