//
//  FSMainTimeline.m
//  FutureStackTimeline
//
//  Created by James on 10/27/13.
//  Copyright (c) 2013 James. All rights reserved.
//

#import "FSMainTimeline.h"
#import <CommonCrypto/CommonDigest.h>

@interface FSMainTimeline ()

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) UIImage *gravatar;
@property (nonatomic, strong) UIImage *john;
@property (nonatomic, strong) UIImage *bill;

@end

@implementation FSMainTimeline

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self pullJSONData];
    
    NSURL *imageURL = [NSURL URLWithString:@"http://www.gravatar.com/avatar/cbaedb898637e8bae878e34dafcb1eed?s=136"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    self.gravatar = [UIImage imageWithData:imageData];
    

    self.john = [self gravatarURL:@"jhwang@newrelic.com"];
    self.bill = [self gravatarURL:@"jhwang@newrelic.com"];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
        UIImageView *image  = (UIImageView *)[cell viewWithTag:10];
        UILabel *name       = (UILabel *)[cell viewWithTag:20];
        UILabel *email      = (UILabel *)[cell viewWithTag:30];
        UILabel *scoreValue = (UILabel *)[cell viewWithTag:40];
        image.image = self.gravatar;
        name.text = @"James Hwang";
        email.text = @"jimmy.wang.usc.golonger@wang.com";
        scoreValue.text = @"43";
    } else if (indexPath.row % 2 == 0) {
        static NSString *VoteCell = @"Vote";
        cell = [tableView dequeueReusableCellWithIdentifier:VoteCell forIndexPath:indexPath];
        
    } else {
        static NSString *ContactCell = @"Contact";
        cell = [tableView dequeueReusableCellWithIdentifier:ContactCell forIndexPath:indexPath];
        
        UIImageView *image  = (UIImageView *)[cell viewWithTag:1010];
        UILabel *name       = (UILabel *)[cell viewWithTag:1020];
        UILabel *email      = (UILabel *)[cell viewWithTag:1030];
        UILabel *twitter    = (UILabel *)[cell viewWithTag:1040];
        image.image = self.list[indexPath.row][@"image"];
        name.text = self.list[indexPath.row][@"name"];
        email.text = self.list[indexPath.row][@"email"];
        twitter.text = self.list[indexPath.row][@"twitter"];
        
    }
    UILabel *label = (UILabel *)[cell viewWithTag:2020];
    label.text = self.list[indexPath.row];
    
    return cell;
}

- (void)pullJSONData
{
    self.list = @[@"Hello",
                  @{@"image": [self gravatarURL:@"jmondo@newrelic.com"],
                    @"name": @"John Gesimondo",
                    @"email":@"jmondo@newrelic.com",
                    @"twitter": @"@jmondo"},
                  @"Today4",
                  @{@"image": [self gravatarURL:@"bkayser@newrelic.com"],
                    @"name": @"Bill Kayser",
                    @"email":@"bkayser@newrelic.com",
                    @"twitter": @"@bravoking"},
                  @"what?",
                  @"Yeahh!",
                  @"Okaayyy"];

                                
    
//    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Space cell's height
    if (indexPath.row == 0) {
        return 207.0f;
    } else {
        return 80.0f;
    }
}

- (UIImage *) gravatarURL:(NSString *)email
{
    NSString *gravatarRootURL = @"http://www.gravatar.com/avatar/";
    NSString *gravatarMD5     = [self md5:email];
    NSString *gravatarURL     = [NSString stringWithFormat:@"%@%@", gravatarRootURL, gravatarMD5];
    NSURL *imageURL           = [NSURL URLWithString:gravatarURL];
    NSData *imageData         = [NSData dataWithContentsOfURL:imageURL];
    
    return [UIImage imageWithData:imageData];
}

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
