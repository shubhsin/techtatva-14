//
//  SSJSONModel.m
//  SSJSONParse
//
//  Created by Shubham Sorte on 13/08/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//  SSJSONParse SS for Shubham Sorte

#import "SSJSONModel.h"
#import "MBProgressHUD.h"

@interface SSJSONModel(){
    
    NSMutableData * responseData;
}

@end

@implementation SSJSONModel

-(instancetype)initWithDelegate:(id<SSJSONModelDelegate>)delegate
{
    if(self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}

-(void)sendRequestWithUrl:(NSURL*)Url
{
    NSURLRequest * request = [NSURLRequest requestWithURL:Url];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    _jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    
    [self.delegate jsonRequestDidCompleteWithDict:_jsonDictionary model:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
