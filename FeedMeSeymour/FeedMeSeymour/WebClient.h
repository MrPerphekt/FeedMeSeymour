//
//  WebClient.h
//  FeedMeSeymour
//
//  Created by Bret Faller on 10/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebClient : NSObject<UIApplicationDelegate>
{
    NSMutableData *responseData;
}

@property (nonatomic, retain) NSString* dataReceivedEventName;

-(void)makeRequest:(NSString*)url;

@end

