//
//  RemoveNoteCommand.m
//  LifeNotes
//
//  Created by amemon on 1/30/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import "Note.h"
#import "NoteStore.h"
#import "RemoveNoteCommand.h"
#import "Tag.h"

@implementation RemoveNoteCommand

+ (void) performWithIndex:(NSInteger)index
{
    Note* n = [NoteStore.defaultStore.allNotes objectAtIndex:index];
    
    //TODO: after removing it, clean up tags as necessary. Remember one tag can (and often will) have multiple notes associated with it. 
    
    [NoteStore.defaultStore removeNote:n];
    [NoteStore.defaultStore saveChanges];
}

@end
