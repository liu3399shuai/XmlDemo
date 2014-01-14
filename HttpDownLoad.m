//
//  HttpDownLoad.m
//  JsomDemo
//
//  Created by mac on 12-12-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HttpDownLoad.h"

@implementation HttpDownLoad

@synthesize mConnection,mData,delegate;

-(HttpDownLoad *)initWithDelegate:(id)dele
{   // 深入了解初始化,把类的成员变量实例化放在这里
    if (self = [super init]) {
        delegate = dele;
        
        if (!mData) {
            mData = [[NSMutableData alloc] initWithCapacity:0];
        }
        
    }
    return self;
}
-(void)downloadFromUrl:(NSString *)url
{
    if (mConnection) {
        [mConnection cancel];
        [mConnection release];
        mConnection = nil;
    }
    mConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
//    mConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
}
//-(void)downloadFromUrlWithAsi:(NSString *)asi
//{
//    mData.length = 0;
//    
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:asi]];
//    request.delegate = self;
////    request.tag = 100;
//    [request startAsynchronous];
//}
//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//    [mData appendData:[request responseData]];
//    if (delegate && [delegate respondsToSelector:@selector(downLoadComplete:)]) {
//        [delegate downLoadComplete:self];
//    }
//}
//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    
//}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [mData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (delegate && [delegate respondsToSelector:@selector(downLoadComplete:)]) {
        [delegate downLoadComplete:self];
    }
}
@end
