//
//  Tag.h
//  LifeNotes
//
//  Created by amemon on 1/29/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Tag : NSManagedObject

@property (nonatomic, strong) NSString * tagName;
@property (nonatomic) double orderingValue;
@property (nonatomic, strong) NSSet *notes;
@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end
