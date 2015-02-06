//
//  UIViewController+ConnectionController.h
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/5/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (ConnectionController)

#pragma mark - Network Connectivity Methods

//Connects initially to vine api and retrieves the JSON
-(void)methodConnectToVineApi:(void(^)(NSDictionary *dictionaryWithVineJSON))completion;

//Retrieves an image
-(void)methodReturnImageFromVineApi:(NSString *)stringWithUrl completion:(void(^)(UIImage *imageReturned))completion;



@end
