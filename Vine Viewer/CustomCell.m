//
//  CustomCell.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/6/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "CustomCell.h"

#import "NSObject+ConnectionController.h"

@interface CustomCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThumbnailUrl;
@property (weak, nonatomic) IBOutlet UILabel *textLabelVideoTitle;
@property (weak, nonatomic) IBOutlet UILabel *textLabelAuthorTitle;

@end

@implementation CustomCell

//Creates tableviewcell for tableview
-(UITableViewCell *)methodCreateCell:(NSDictionary *)dictionaryWithVideoInformation{
    
    [self methodReturnImageFromVineApi:dictionaryWithVideoInformation[@"thumbnailUrl"] completion:^(UIImage *imageReturned) {
        self.imageView.image = imageReturned;
    }];
    
    return self;
    
}



@end
