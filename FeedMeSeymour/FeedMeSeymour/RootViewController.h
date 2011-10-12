//
//  RootViewController.h
//  FeedMeSeymour
//
//  Created by Bret Faller on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterClient.h"

@interface RootViewController : UITableViewController
{
    NSMutableArray* tweets;
}

@property (nonatomic, retain) TwitterClient* twitterClient;

-(void)tweetsReceived:(NSNotification*)tweetsReceived;

@end
