//
//  DetailViewController.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/5/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "DetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DetailViewController()

//Container for the video player
@property (weak, nonatomic) IBOutlet UIView *viewWithVideoPlayer;

//Video player itself
@property (nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation DetailViewController

#pragma mark View Controller Lifecycle Methods
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //Initialize the video player
    NSURL *urlForVideo = [[NSURL alloc] initWithString:@"http://v.cdn.vine.co/r/videos_r2/87A2E4519A1164309800809558016_3adb2e23be6.1.5.16213636071683769459.mp4?versionId=t_Edd7jN.ldlS44UdaZW9e.VpSvrB59_"];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlForVideo];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    //Set the frame and add it to the subview
    [self.moviePlayer.view setFrame:self.viewWithVideoPlayer.bounds];
    
    [self.viewWithVideoPlayer addSubview:self.moviePlayer.view];
    [self.moviePlayer prepareToPlay];

    [self.moviePlayer play];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.moviePlayer stop];
}

@end
