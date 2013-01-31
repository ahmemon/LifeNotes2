//
//  AddNoteCommand.h
//  LifeNotes
//
//  Created by amemon on 1/30/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddNoteCommand : NSObject

/** Adds a note to the model, parses out the hash tags, saves the model. */
+ (void) performWithString:(NSString*)string;

@end
