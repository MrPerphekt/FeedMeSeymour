//
//  TwitterClient.m
//  FeedMeSeymour
//
//  Created by Bret Faller on 10/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterClient.h"
#import "SBJson.h"

@implementation TwitterClient

@synthesize tweetsReceivedEventName;

- (id)init
{
    self = [super init];
    if (self) 
    {
        tweetsReceivedEventName = @"tweetsReceivedEvent";
        
        _webClient = [[[WebClient alloc] init] retain];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:[_webClient dataReceivedEventName] object:nil ];
    }
    
    return self;
}

- (void)searchTwitter:(NSString*)searchCriteria resultsPerPage:(int)resultsPerPage
{
    NSString* url = @"http://search.twitter.com/search.json?"; 
    NSString* fullyQualifiedUrl = [[NSString alloc] initWithFormat:@"%@q=%@&rpp=%d", url, searchCriteria, resultsPerPage];
    
    [_webClient makeRequest:fullyQualifiedUrl];        
}

-(void)dataReceived: (NSNotification *) notification
{    
    NSDictionary *results = [(NSString*)[notification object] JSONValue];     

    NSArray *tweets = [results objectForKey:@"results"];  
    
    [[NSNotificationCenter defaultCenter] postNotificationName:tweetsReceivedEventName object:tweets];
}

- (void)dealloc
{
    [_webClient release];
    [super dealloc];
}

@end
