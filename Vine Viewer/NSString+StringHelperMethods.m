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

@end

