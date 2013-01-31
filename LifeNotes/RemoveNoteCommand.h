//
//  RemoveNoteCommand.h
//  LifeNotes
//
//  Created by amemon on 1/30/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoveNoteCommand : NSObject

+ (void) performWithIndex:(NSInteger)index;

@end
