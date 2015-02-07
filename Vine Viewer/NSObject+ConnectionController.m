//
//  UIViewController+ConnectionController.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/5/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "NSObject+ConnectionController.h"
#import <SAMCache/SAMCache.h>

@implementation NSObject (ConnectionController)

#pragma mark - Network Connectivity Methods

//Connects initially to vine api and retrieves the JSON
-(void)methodConnectToVineApi:(void (^)(NSDictionary *))completion{
    NSString *urlString = @"https://vine.co/api/timelines/users/918753190470619136";
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    //Gets the JSON from the Vine Link
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        NSDictionary *dictionaryWithVineFeed = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //If the HTTP status code is 200, proceed!
            if (((NSHTTPURLResponse *)response).statusCode == 200){
            completion(dictionaryWithVineFeed);
            }else{
                completion(nil);
                UIAlertView *alertViewShowingError = [[UIAlertView alloc] initWithTitle:@"Woops!" message:@"There was an error, unable to connect at this moment" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alertViewShowingError show];
            }
        });
        
        //  Uncomment for debugging
        //        NSLog(@"Returned JSON is.. %@", dictionaryWithVineFeed);
        //        NSLog(@"Error is.. %@", error);
        //        NSLog(@"Response code is.. %ld", (long)((NSHTTPURLResponse *)response).statusCode);
        
    }];
    
    [task resume];
}

//Returns an image
-(void)methodReturnImageFromVineApi:(NSString *)stringWithUrl completion:(void (^)(UIImage *))completion{
    if (stringWithUrl.length == 0 || stringWithUrl == nil){
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:stringWithUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        //Caches the image for use in the future (saves data!)
        [[SAMCache sharedCache] setImage:image forKey:stringWithUrl];
        NSLog(@"Stored! %@", stringWithUrl);
        
       
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
        
    }];
    
    [task resume];
    
}

@end
