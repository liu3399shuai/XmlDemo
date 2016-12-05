// 整理 master  和 branch

#import <Foundation/Foundation.h>
#import "HttpDownLoadDelegate.h"
@class HttpDownLoadDelegate;
//#import "ASIHTTPRequest.h"
    // 这个类有两个作用 1:完成下载任务 2:将数据传给Controller
@interface HttpDownLoad : NSObject <NSURLConnectionDataDelegate>
{
@private
    NSMutableData *mData;
    NSURLConnection *mConnection;
    id<HttpDownLoadDelegate> delegate;
}
@property (nonatomic,readonly) NSURLConnection *mConnection;
@property (nonatomic,readonly) NSMutableData *mData;
@property (nonatomic,assign) id<HttpDownLoadDelegate> delegate;

-(HttpDownLoad *)initWithDelegate:(id)dele;
-(void)downloadFromUrl:(NSString *)url;
//-(void)downloadFromUrlWithAsi:(NSString *)asi;

@end
