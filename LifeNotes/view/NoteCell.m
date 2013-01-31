//
//  NoteCell.m
//  LifeNotes
//
//  Created by amemon on 1/29/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import "NoteCell.h"

@implementation NoteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
