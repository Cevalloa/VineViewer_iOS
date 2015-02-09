//
//  DetailViewController.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/5/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NSString+StringHelperMethods.h"
#import "NSObject+ConnectionController.h"

@interface DetailViewController()

//Container for the video player
@property (weak, nonatomic) IBOutlet UIView *viewWithVideoPlayer;

//Video player itself
@property (nonatomic) MPMoviePlayerController *moviePlayer;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;

@property (weak, nonatomic) IBOutlet UILabel *labelForName;
@property (weak, nonatomic) IBOutlet UILabel *labelForDate;
@property (weak, nonatomic) IBOutlet UILabel *labelForTotalLikes;
@property (weak, nonatomic) IBOutlet UILabel *labelForTotalRevines;
@property (weak, nonatomic) IBOutlet UILabel *labelForTotalComments;


@end

@implementation DetailViewController

#pragma mark View Controller Lifecycle Methods

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //Sets up all the UI Elements, minus the video
    [self methodSetupUIElements];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    //Sets up the  video
    [self methodSetupVideoPlayer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.moviePlayer stop];
}

#pragma mark Movie Player Methods

-(void)methodSetupVideoPlayer{
    NSURL *urlForVideo = [[NSURL alloc] initWithString:self.dictionaryWithVideoDetailData[@"videoLowURL"]];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlForVideo];
    
    //Set the frame and add it to the subview
    [self.moviePlayer.view setFrame:self.viewWithVideoPlayer.bounds];
    
    [self.viewWithVideoPlayer addSubview:self.moviePlayer.view];
    [self.moviePlayer prepareToPlay];
    
    [self.moviePlayer play];
}

#pragma mark - UI Element Methods

-(void)methodSetupUIElements{
    self.labelForName.text = self.dictionaryWithVideoDetailData[@"username"];
    
    //Grabs number from data ], turns into string ], then shortens it]
    NSString *stringLikesCount = [[self.dictionaryWithVideoDetailData[@"likes"][@"count"] stringValue] methodShortenNumber];
    NSString *stringRepostsCount = [[self.dictionaryWithVideoDetailData[@"reposts"][@"count"] stringValue] methodShortenNumber];
    NSString *stringCommentsCount = [[self.dictionaryWithVideoDetailData[@"comments"][@"count"] stringValue] methodShortenNumber];
    NSString *stringAvatarUrl = self.dictionaryWithVideoDetailData[@"avatarUrl"];

    
    //Sets up the IBOutlets with their respective additional string
    self.labelForTotalLikes.text = [NSString stringWithFormat:@"%@ Likes", stringLikesCount];
    self.labelForTotalRevines.text = [NSString stringWithFormat:@"%@ Revines", stringRepostsCount];
    self.labelForTotalComments.text = [NSString stringWithFormat:@"%@ Comments", stringCommentsCount];
    
    //Turns Date from string into a custom format
    self.labelForDate.text = [self.dictionaryWithVideoDetailData[@"created"] methodFormatStringWithDate];
    
    //Fetches and sets the imageView as teh avatarUrl
    [self methodReturnImageFromVineApi:stringAvatarUrl completion:^(UIImage *imageReturned) {
        self.imageViewAvatar.image = imageReturned;
    }];
    
}

@end
