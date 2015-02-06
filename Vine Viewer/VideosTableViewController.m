//
//  VideosTableViewController.m
//  Vine Viewer
//
//  Created by Alex Cevallos on 2/5/15.
//  Copyright (c) 2015 AlexCevallos. All rights reserved.
//

#import "VideosTableViewController.h"
#import "CustomCell.h"
#import "NSObject+ConnectionController.h"

@interface VideosTableViewController(){

    NSArray *arrayWithVineRecords;
}

@end

@implementation VideosTableViewController

#pragma mark - View Controller Lifecycle Methods
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //Method from modal layer
    [self methodConnectToVineApi:^(NSDictionary *dictionaryWithVineJSON) {
        
        //Assigns the vine records to this array
        arrayWithVineRecords = dictionaryWithVineJSON[@"data"][@"records"];
        
        if (dictionaryWithVineJSON != nil){
            [self.tableView reloadData];
        }
        
    }];
    
}

#pragma mark - Table View Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayWithVineRecords count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *tableViewCellForTable = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    return [tableViewCellForTable methodCreateCell:arrayWithVineRecords[indexPath.row]];
}

@end
