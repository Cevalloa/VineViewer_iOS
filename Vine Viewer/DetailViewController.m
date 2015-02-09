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

//Containers for the video player
//viewVideoContainerStarting:-
//viewVideoContainerEndPoint:- Connected with autolayout, snaps animation to this

@property (nonatomic) UIView *viewVideoContainerStarting;
@property (weak, nonatomic) IBOutlet UIView *viewVideoContainerEndPoint;

//Video player itself
@property (nonatomic) MPMoviePlayerController *moviePlayer;

//For animation
@property (nonatomic) UIDynamicAnimator *animator;

//IBoutlet imageViews
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAvatar;

//IBOutlet Labels
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
    [super viewDidAppear:animated];

    //Snap the video view down
    [self methodAnimateSnapDown];
    
    //Sets up the  video to play
    [self methodSetupVideoPlayer];

    //[self.viewFake addConstraints:self.viewWithVideoPlayer.constraints];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.moviePlayer stop];
}

#pragma mark Movie Player Methods

-(void)methodSetupVideoPlayer{
    NSURL *urlForVideo = [[NSURL alloc] initWithString:self.dictionaryWithVideoDetailData[@"videoLowURL"]];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlForVideo];
    
    //Set movie player frame to the container view
    [self.moviePlayer.view setFrame:self.viewVideoContainerStarting.bounds];
    
    //Add movie player to the container view
    [self.viewVideoContainerStarting addSubview:self.moviePlayer.view];
    [self.moviePlayer prepareToPlay];
    
    [self.moviePlayer play];
}

#pragma mark UI Animation Methods
-(void)methodAnimateSnapDown{
    
    //Create view container on top (starting point)
    self.viewVideoContainerStarting = [[UIView alloc] initWithFrame:CGRectMake(0.0, -320.0, self.viewVideoContainerEndPoint.frame.size.width, self.viewVideoContainerEndPoint.frame.size.height)];
        
    //Add the starting container to the end point
    [self.viewVideoContainerEndPoint addSubview:self.viewVideoContainerStarting];
    
    //Create animator with reference to top level view
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //Snap to the center of viewVideoContainerEndPoint (view with autolayout)
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.viewVideoContainerStarting snapToPoint:self.viewVideoContainerEndPoint.center];
    [self.animator addBehavior:snap];
    
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
