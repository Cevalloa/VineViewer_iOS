//
//  VideosTableViewController.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/5/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "VideosTableViewController.h"
#import "UIViewController+ConnectionController.h"

@implementation VideosTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //Method from modal layer
    [self methodConnectToVineApi:^(NSDictionary *dictionaryWithVineJSON) {
    
        if (dictionaryWithVineJSON == nil){
            NSLog(@"Dictionary is empty!");
        }else{
            NSLog(@"The vine api returned.. %@", dictionaryWithVineJSON);
        }
        
    }];
    
}

@end
