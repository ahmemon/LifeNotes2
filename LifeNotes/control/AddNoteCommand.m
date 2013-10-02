//
//  AddNoteCommand.m
//  LifeNotes
//
//  Created by amemon on 1/30/13.
//  Copyright (c) 2013 Amir Memon. All rights reserved.
//

#import "AddNoteCommand.h"
#import "Note.h"
#import "NoteStore.h"
#import "Tag.h"

@implementation AddNoteCommand

+ (void) performWithString:(NSString*)string
{
    if (string.length == 0)
        return;
    
    Note* n = [NoteStore.defaultStore createNote];
    n.noteName = string;
    
    NSError* err;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(^| )(#[A-Z][A-Z0-9]*)" options:NSRegularExpressionCaseInsensitive error:&err];
    
    NSUInteger numMatches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
    NSLog(@"Num of tags in: %@ - %d", string, numMatches);
    
    __block NSUInteger count = 0;
    [regex enumerateMatchesInString:string options:0 range:NSMakeRange(0, [string length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        NSRange secondHalfRange = [match rangeAtIndex:2];
        NSString* tn = [string substringWithRange:secondHalfRange];
        Tag* t = [NoteStore.defaultStore tagWithName:tn];
        if (!t)
        {
            t = [NoteStore.defaultStore createTag];
            t.tagName = tn;
        }
        [t addNotesObject:n];
        // No need to recipcrocate. CoreData will do the equivalent of [n addTagObject:t]. If you do it anyway, it makes no difference (thankfully). 
        if (++count >= 100) *stop = YES;
    }];
    
    [NoteStore.defaultStore saveChanges];
}
@end
