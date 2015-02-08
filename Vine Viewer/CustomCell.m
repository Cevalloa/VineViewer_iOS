//
//  CustomCell.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/6/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "CustomCell.h"
#import <SAMCache/SAMCache.h>

#import "NSObject+ConnectionController.h"

@interface CustomCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThumbnailUrl;
@property (weak, nonatomic) IBOutlet UILabel *textLabelVideoTitle;
@property (weak, nonatomic) IBOutlet UILabel *textLabelAuthorTitle;

@end

@implementation CustomCell

//Creates tableviewcell for tableview
-(UITableViewCell *)methodCreateCell:(NSDictionary *)dictionaryWithVideoInformation{
    
    self.textLabelVideoTitle.text = dictionaryWithVideoInformation[@"description"];
    self.textLabelAuthorTitle.text = dictionaryWithVideoInformation[@"username"];
    
   // SAMCache checks if image key exists. (If it exists, it means the image is already cached)
    UIImage *photo = [[SAMCache sharedCache] imageForKey:dictionaryWithVideoInformation[@"thumbnailUrl"]];
    
    // If photo is cached, no need to network connect.. use the cached image instead
    if(photo){
      //  NSLog(@"Already here! %@", dictionaryWithVideoInformation[@"thumbnailUrl"]);
        self.imageViewThumbnailUrl.image = photo;
        return self;
    }

    
    [self methodReturnImageFromVineApi:dictionaryWithVideoInformation[@"thumbnailUrl"] completion:^(UIImage *imageReturned) {
        self.imageViewThumbnailUrl.image = imageReturned;
       
    }];
    
    return self;
    
}



@end
