//
//  UIViewController+ConnectionController.h
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/5/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ConnectionController)

-(void)methodConnectToVineApi:(void(^)(NSDictionary *dictionaryWithVineJSON))completion;

@end
