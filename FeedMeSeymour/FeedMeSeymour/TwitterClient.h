//
//  TwitterClient.h
//  FeedMeSeymour
//
//  Created by Bret Faller on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebClient.h"

@interface TwitterClient : NSObject<UIApplicationDelegate>
{
    WebClient* _webClient;
}

@property (nonatomic, retain) NSString* tweetsReceivedEventName;

-(void)dataReceived: (NSNotification *) notification;
-(void)searchTwitter:(NSString*)searchCriteria resultsPerPage:(int)resultsPerPage;

@end