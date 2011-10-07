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

@property (nonatomic, retain) TwitterClient* _twitterClient;

@end
