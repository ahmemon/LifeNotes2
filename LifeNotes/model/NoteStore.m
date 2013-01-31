//
//  NoteStore.m
//  LifeNotes
//
//  Created by amemon on 1/29/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import "Note.h"
#import "Tag.h"
#import "NoteStore.h"

@implementation NoteStore

+ (NoteStore *)defaultStore
{
    static NoteStore *defaultStore = nil;
    if(!defaultStore)
        defaultStore = [[super alloc] init];
    
    return defaultStore;
}

- (id)init
{
    self = [super init];
    if(self) {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // Specify a path for the SQLite file
        NSString *path = [self noteArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        // Save Undo features for a future release.
        [context setUndoManager:nil];
        
        [self loadAllNotesAndTags];
    }
    return self;
}

- (void)loadAllNotesAndTags
{
    if (!allNotes)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Note"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allNotes = [[NSMutableArray alloc] initWithArray:result];
    }
    
    if (!allTags)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Tag"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allTags = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSString*)noteArchivePath
{
    NSArray* documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

- (void)removeNote:(Note*)p
{
    [context deleteObject:p];
    [allNotes removeObjectIdenticalTo:p];
}

- (NSArray*)allNotes
{
    return allNotes;
}

- (NSArray*) allTags
{
    return allTags;
}

- (Note*)createNote
{
    double order;
    if ([allNotes count] == 0) {
        order = 1.0;
    } else {
        order = [[allNotes lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %d Notes, order = %.2f", [allNotes count], order);
    
    Note *p = [NSEntityDescription insertNewObjectForEntityForName:@"Note"
                                               inManagedObjectContext:context];
    
    [p setOrderingValue:order];
    
    [allNotes addObject:p];
    
    return p;
}

- (Tag*)createTag
{
    double order;
    if ([allTags count] == 0) {
        order = 1.0;
    } else {
        order = [[allTags lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %d Tags, order = %.2f", [allTags count], order);
    
    Tag *p = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
                                            inManagedObjectContext:context];
    
    [p setOrderingValue:order];
    
    [allTags addObject:p];
    
    return p;
}

@end
