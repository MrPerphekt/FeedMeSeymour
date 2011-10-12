//
//  RootViewController.m
//  FeedMeSeymour
//
//  Created by Bret Faller on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize twitterClient;

- (void)viewDidLoad
{
    [super viewDidLoad];

    tweets = [[NSMutableArray alloc] init];
    [tweets retain];
    
    twitterClient = [[TwitterClient alloc] init];
    [twitterClient retain];        
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tweetsReceived:) name:[twitterClient tweetsReceivedEventName] object:nil ];
    
    [twitterClient searchTwitter:@"San%20Diego%20Chargers" resultsPerPage:25];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tweets count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
    // The header for the section is the region name -- get this from the region at the section index.
    return @"Twitter Search";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
                
        NSDictionary *tweet = [tweets objectAtIndex:[indexPath row]];  
        cell.textLabel.text = [tweet objectForKey:@"text"];  
        cell.textLabel.adjustsFontSizeToFitWidth = NO;  
        cell.textLabel.font = [UIFont systemFontOfSize:12];  
        cell.textLabel.numberOfLines = 4;  
        cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap;  
        
        cell.detailTextLabel.text = [tweet objectForKey:@"from_user"];  
        
        NSURL *url = [NSURL URLWithString:[tweet objectForKey:@"profile_image_url"]];  
        NSData *data = [NSData dataWithContentsOfURL:url];  
        cell.imageView.image = [UIImage imageWithData:data];  
        cell.selectionStyle = UITableViewCellSelectionStyleNone;         
    }

    // Configure the cell.
    return cell;
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
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

-(void)tweetsReceived:(NSNotification*)tweetsReceived
{
    for (int i = 0; i < [[tweetsReceived object] count]; i++)
    {
        [tweets addObject:[[tweetsReceived object] objectAtIndex:i]];
    }    
    
    [[self tableView] reloadData];
    
    NSLog(@"Data Reloaded");
}

- (void)dealloc
{
    [twitterClient release];
    twitterClient = nil;
    
    [tweets release];
    tweets = nil;
    
    [super dealloc];
}

@end
