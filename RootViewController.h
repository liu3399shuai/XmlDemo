//
//  RootViewController.h
//  XmlDemo
//
//  Created by mac on 12-12-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDownLoad.h"
#import "EGORefreshTableHeaderView.h"

@interface RootViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,HttpDownLoadDelegate,EGORefreshTableHeaderDelegate>
{
@private
    UITableView *mTableView;
    NSMutableArray *mDataArray;
    HttpDownLoad *httpDownload;
    NSInteger numInPage;
    NSInteger pageIndex;
    NSInteger pageCount;
    NSInteger totalcount;
    NSArray *curArray;
    
    UILabel *mLoadMore;
    BOOL canLoadMore;
    
    EGORefreshTableHeaderView *refreshView;
    BOOL isLoading;
}
@property (nonatomic,retain) NSArray *curArray;

@end
