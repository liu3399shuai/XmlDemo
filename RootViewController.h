// 测试pull request在有conflict时候的情况

#import <UIKit/UIKit.h>
#import "HttpDownLoad.h"
#import "EGORefreshTableHeaderView.h"
// 关于添加文件资源须知(不能托) 
// 在工程名字上 右击 Add Files to "..."  并且选中 Destination 的按钮 选中文件或文件夹 按添加

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
