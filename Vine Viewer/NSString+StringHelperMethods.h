//
//  NSString+StringHelperMethods.h
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/8/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringHelperMethods)

//Shortens string numbers over 1000..
//ex: 11000 -> 11k && 999 -> 999
-(NSString *)methodShortenNumber;


//Takes String in date foramt, returns new custom format
-(NSString *)methodFormatStringWithDate;
@end
