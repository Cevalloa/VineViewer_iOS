//
//  NSString+StringHelperMethods.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/8/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "NSString+StringHelperMethods.h"

@implementation NSString (StringHelperMethods)

//Shortens string numbers over 1000.. ex: 11000 -> 11k && 999 -> 999
-(NSString *)methodShortenNumber{
    
    int numberForIndex = self.length - 3;
    
    if (numberForIndex <= 0) {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@k",[self substringToIndex:numberForIndex]];
    
}

-(NSString *)methodFormatStringWithDate{
    
    //Format from the API is yyyy-MM-dd'T'hh:mm:ss.AAAAAA
    
    
    NSDateFormatter *dateSetsFormat = [[NSDateFormatter alloc] init];
    
    //Set to the API's date feed (So the NSString can be read)
    [dateSetsFormat setDateFormat:@"yyyy-MM-dd"];
    
    //Convert the incoming string to a date
    NSDate *dateConvertedFromString = [dateSetsFormat dateFromString:[self substringToIndex:10]];
    
    //Set to the format we want to show
    [dateSetsFormat setDateFormat:@"MMM dd yyyy"];
    
    return [dateSetsFormat stringFromDate:dateConvertedFromString];
}


@end

