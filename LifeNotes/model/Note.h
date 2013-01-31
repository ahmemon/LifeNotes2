//
//  Note.h
//  LifeNotes
//
//  Created by amemon on 1/29/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic) double orderingValue;
@property (nonatomic, strong) NSString * noteName;
@property (nonatomic, strong) NSSet *tags;
@end

@interface Note (CoreDataGeneratedAccessors)

- (void)addTagsObject:(NSManagedObject *)value;
- (void)removeTagsObject:(NSManagedObject *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
