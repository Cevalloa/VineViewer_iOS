//
//  UIViewController+ConnectionController.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/5/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "UIViewController+ConnectionController.h"

@implementation UIViewController (ConnectionController)

-(void)methodConnectToVineApi:(void (^)(NSDictionary *))completion{
    NSString *urlString = @"https://vine.co/api/timelines/users/918753190470619136";
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    //Gets the JSON from the Vine Link
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        NSDictionary *dictionaryWithVineFeed = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
   //  Uncomment for debugging
//        NSLog(@"Returned JSON is.. %@", dictionaryWithVineFeed);
//        NSLog(@"Error is.. %@", error);
//        NSLog(@"Response code is.. %ld", (long)((NSHTTPURLResponse *)response).statusCode);
        
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
    }];
    
    [task resume];
}

@end
