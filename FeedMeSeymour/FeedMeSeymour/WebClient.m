//
//  WebClient.m
//  FeedMeSeymour
//
//  Created by Bret Faller on 10/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebClient.h"

@implementation WebClient

@synthesize dataReceivedEventName;

- (id)init
{
    self = [super init];
    if (self) 
    {
        dataReceivedEventName = @"webDataReceivedEvent";
    }
    
    return self;
}

-(void)makeRequest:(NSString *)url
{
    if (responseData != nil)
    {
        [responseData release];
        [responseData dealloc];
    }
    
    responseData = [[NSMutableData data] retain];  
    
    NSURLRequest *request = [NSURLRequest requestWithURL:  
                             [NSURL URLWithString:url]];    
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];  
}

#pragma mark NSURLConnection Delegate methods  

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{  
    [responseData setLength:0];  
}  

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{  
    [responseData appendData:data];  
}  

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{    
    NSLog(@"Connection failed: %@", [error description]);
}  

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{  
    [connection release];  
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];  
    [responseData release];  
    
    // Pass responseString to class
    [[NSNotificationCenter defaultCenter] postNotificationName:dataReceivedEventName object:responseString ];    
}

-(void)dealloc
{
    if (responseData != nil)
    {
        [responseData release];
        [responseData dealloc];
    }
    
    [super dealloc];
}
@end
