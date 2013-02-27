//
//  NoteStore.h
//  LifeNotes
//  Amir was here
//  Created by amemon on 1/29/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class Note;
@class Tag;

@interface NoteStore : NSObject
{
    NSMutableArray *allNotes;
    NSMutableArray *allTags;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+ (NoteStore *)defaultStore;

- (NSString*)noteArchivePath;

- (void)removeNote:(Note*)p;

- (NSArray*)allNotes;
- (NSArray*)allTags;

- (Tag*)tagWithName:(NSString*)tagName;

- (Note*)createNote;
- (Tag*)createTag;

//TODO: - (void)moveNoteAtIndex:(int)from
//                toIndex:(int)to;


- (BOOL)saveChanges;

- (void)loadAllNotesAndTags;

@end
